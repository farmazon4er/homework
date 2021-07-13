def cs_or_not(slovo)
  if slovo[slovo.size - 2 ,2] == "CS"
  puts 2 ** slovo.size
  else
  puts slovo.reverse
  end	
end

puts "Введите слово"
slovo = gets.chomp.to_s
puts "Введите число"
number = gets.chomp

cs_or_not(slovo)
