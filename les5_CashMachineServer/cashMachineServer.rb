require 'socket'
require 'rack'
require 'rack/utils'

server = TCPServer.new('0.0.0.0', 3000)

class CashMachine  CONST_START_MONEY = 100.0

  def initialize
    @balance = File.exist?("data/balance.txt") ? File.read("data/balance.txt").to_f : CONST_START_MONEY
  end

  def balance
    "Your balance - #{@balance.round(2)}"
  end

  def deposit(dep)
    if dep > 0
      @balance = @balance + dep
      File.write("data/balance.txt", @balance)
      return balance
    else
      return "Incorrect amount"
    end
  end

  def withdraw(cash)
    if (@balance >= cash) && (cash > 0)
      @balance -= cash
      File.write("data/balance.txt", @balance)
      return balance
    elsif (@balance < cash) && (cash > 0)
      return "There are not enough funds on the account"
    else
      return "incorrect amount"
    end
  end
end

class App
  def call(env)
    req = Rack::Request.new(env)
    cashmachine = CashMachine.new
    case req.path_info
    when '/balance'
      [200, {'Content-Type' => 'text/html'}, [cashmachine.balance]]
 when '/deposit'
   [200, {'Content-Type' => 'text/html'}, [cashmachine.deposit(env['PARAMS'].to_f)]]
 when '/withdraw'
   [200, {'Content-Type' => 'text/html'}, [cashmachine.withdraw(env['PARAMS'].to_f)]]
 else
   [404, {'Content-Type' => 'text/html'}, ["Not found"]]
 end
  end
end

app = App.new

while connection = server.accept
  request = connection.gets
  method, full_path = request.split(' ')
  path = full_path.split('?')[0]
  result = full_path.split('=')[1]

  status, headers, body = app.call({
                                     'REQUEST_METHOD' => method,
                                     'PATH_INFO' => path,
                                     'PARAMS' => result
                                      })

  connection.print("HTTP/1.1 #{status}\r\n")

  headers.each { |key, value|  connection.print("#{key}: #{value}\r\n") }

  connection.print "\r\n"

  body.each { |part| connection.print(part) }

  connection.close
end