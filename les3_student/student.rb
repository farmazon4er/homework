def student_input(current_path, students_list)
file_data = File.read(current_path).split("\n")
file_data.each { |item|
  item = item.split
  name = item[0] + ' ' + item[1]
  age = item[2].to_i
  students_list[name] = age
}
end

def program(students_list, result, current_path_result)
  loop do
    puts "Введите возраст студента или -1 для выхода"
    age_in = gets.chomp.to_i
    if age_in == -1
      puts "Ввод данных окончен"
      break
    else
      students_list.each {|name, age|
        if age == age_in
          puts "Найден студент #{name}"
          unless result.has_key?(name)
            File.write(current_path_result, "#{name} #{age}\n", mode: "a")
            result[name] = age
          end
        end
      }

      if students_list.size == result.size
        puts "Вы ввели всех студентов"
        break
      end
    end

  end
end

current_path_student = "data/students.txt"
current_path_result = "data/result.txt"
students_list = Hash.new
result = Hash.new
student_input(current_path_student, students_list)
File.write(current_path_result, '')
program(students_list, result, current_path_result)
puts File.read(current_path_result)