class CashMachine
  @current_path_balance = "data/balance.txt"
  CONST_START_MONEY = 100.0
  @operation = "Введите какую операцию хотите выполнить?
D - внести депозит
W - снять средства
B - вывести баланс
Q - выход"

  def self.init
    @balance = File.exist?(@current_path_balance) ? File.read(@current_path_balance).to_f : CONST_START_MONEY
    self.machine_work
    File.write(@current_path_balance, @balance)
  end

  def self.balance_output
    puts "Ваш баланс - #{@balance.round(2)}"
  end

  def self.deposit
    puts "Введите сумму депозита, сумма должна быть больше ноля"
    dep = gets.chomp.to_f
    if dep > 0
      @balance = @balance + dep
      balance_output
    else
      puts "Вы ввели некоректную сумму"
    end
  end

  def self.withdraw
    puts "Введите сумму для снятия, сумма должна быть больше ноля"
    cash = gets.chomp.to_f
    if (@balance >= cash) && (cash > 0)
      @balance -= cash
      balance_output
    elsif (@balance < cash) && (cash > 0)
      puts "На счету недостаточно средств"
    else
      puts "Введене некорректная сумма"
    end
  end

  def self.machine_work
    loop do
      puts @operation
      oper = gets.chomp.to_s.upcase
      case oper
      when "B"
        self.balance_output
      when "D"
        self.deposit
      when "W"
        self.withdraw
      when "Q"
        break
      else
        puts "Вы ввели неправильную команду, повторите ввод"
      end
    end
  end
end

CashMachine.init




