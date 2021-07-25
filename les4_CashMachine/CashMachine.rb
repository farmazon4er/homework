class CashMachine
  CONST_START_MONEY = 100.0
  @@operation = "Введите какую операцию хотите выполнить?
D - внести депозит
W - снять средства
B - вывести баланс
Q - выход"

  def initialize
    @balance = File.exist?("data/balance.txt") ? File.read("data/balance.txt").to_f : CONST_START_MONEY
  end

  def init
    loop do
      puts @@operation
      oper = gets.chomp.to_s.upcase
      case oper
      when "B"
        balance
      when "D"
        deposit
      when "W"
        withdraw
      when "Q"
        break
      else
        puts "Вы ввели неправильную команду, повторите ввод"
      end
    end
    File.write("data/balance.txt", @balance)
  end

  def balance
    puts "Ваш баланс - #{@balance.round(2)}"
  end

  def deposit
    puts "Введите сумму депозита, сумма должна быть больше ноля"
    dep = gets.chomp.to_f
    if dep > 0
      @balance = @balance + dep
      balance
    else
      puts "Вы ввели некоректную сумму"
    end
  end

  def withdraw
    puts "Введите сумму для снятия, сумма должна быть больше ноля"
    cash = gets.chomp.to_f
    if (@balance >= cash) && (cash > 0)
      @balance -= cash
      balance
    elsif (@balance < cash) && (cash > 0)
      puts "На счету недостаточно средств"
    else
      puts "Введене некорректная сумма"
    end
  end

end

cash = CashMachine.new
cash.init