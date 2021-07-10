def balance_input(currnet_path_balance, start_money)
  if !File.exist?(currnet_path_balance)
    start_money
  else
    File.read(currnet_path_balance).to_f
  end
end

current_path_balance = "data/balance.txt"
CONST_START_MONEY = 100.0
operation = "Введите какую операцию хотите выполнить?
D - внести депозит
W - снять средства
B - вывести баланс
Q - выход"
balance = balance_input(current_path_balance, CONST_START_MONEY)
puts balance

loop do
  puts operation
  oper = gets.chomp.to_s.upcase
  case oper
  when "B"
    puts "Ваш баланс - #{balance}"
  when "D"
    puts "Введите сумму депозита"
    dep = gets.chomp.to_f
    if dep > 0
      balance = balance + dep
      puts "Ваш баланс - #{balance}"
    else
      puts "Вы ввели некоректную сумму"
    end
  when "W"
    puts "Какую сумму хотите снять?"
    cash = gets.chomp.to_f
    if (balance >= cash) && (cash > 0)
      balance = balance - cash
      puts "Ваш баланс - #{balance}"
    elsif (balance < cash) && (cash > 0)
      puts "На счету недостаточно средств"
    else
      puts "Введене некорректная сумма"
    end
  when "Q"
    break
  else
    puts "Вы ввели неправильную команду, повторите ввод"
  end
end
File.write(current_path_balance, balance)