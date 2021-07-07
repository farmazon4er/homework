def cs_or_not(slovo, number)
  if slovo[slovo.size - 2 ,2] == "CS"
  puts number ** slovo.size
  else
  puts slovo.reverse
  end	
end

puts "Введите слово"
slovo = gets.chomp.to_s
puts "Введите число"
number = gets.chomp.to_i

cs_or_not(slovo, number)
