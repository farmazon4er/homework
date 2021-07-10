def pokemon_input(n, pok_list)
(n).times {|i|
  puts "Введите имя #{i+1} покемона"
  name = gets.chomp.to_s
  puts "Введите цвет #{i+1} покемона"
  color = gets.chomp.to_s
  pok_list[name] = color
    }
end

puts "Введите количество покемонов"
n = gets.chomp.to_i
pok_list = Hash.new
pokemon_input(n, pok_list)
pok_list.each {|name, color| puts "[{ name: '#{name}', color: '#{color}' }]" }
