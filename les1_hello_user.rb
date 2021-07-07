def hello_user

age = nil
firstname = ""
surname = ""

puts "Скажите своё имя."
firstname = gets.chomp.to_s
puts "Скажите свою фамилию"
surname = gets.chomp.to_s

  loop do
    puts "Cкажите свой возраст"
    age = gets.chomp.to_i
    if (age > 0) && (age < 120) 
    break 
    else
    puts "Введите корректный возраст"
    end
  end

  if age < 18 
  puts "Привет, #{firstname} #{surname}. Тебе меньше 18 лет, но начать учиться программировать никогда не рано."
  else 
  puts  "Привет, #{firstname} #{surname}. Самое время заняться делом!"
  end
end




hello_user