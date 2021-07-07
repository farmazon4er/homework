def number20(a, b)
	if a == 20 || b == 20
	puts 20
    else
    puts a + b
    end
end 


puts "Введите первое число"
a = gets.chomp.to_f 
puts "Введите второе число"
b = gets.chomp.to_f

number20(a, b)