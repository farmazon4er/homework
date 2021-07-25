require 'rack'

class CashMachine
  CONST_START_MONEY = 100.0

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
      return "Not enough money"
    else
      return "Incorrect amount"
    end
  end
end

class Server
  def call(env)
    req = Rack::Request.new(env)
    cashmachine = CashMachine.new
    case req.path_info
    when /deposit/
      [200, {'Content-Type' => 'text/html'}, [cashmachine.deposit(req.params['value'].to_f)]]
    when /balance/
      [200, {'Content-Type' => 'text/html'}, [cashmachine.balance]]
    when /withdraw/
      [200, {'Content-Type' => 'text/html'}, [cashmachine.withdraw(req.params['value'].to_f)]]
    else
      [404, {'Content-Type' => 'text/html'}, ["Not found"]]
    end
  end
end

run Server.new