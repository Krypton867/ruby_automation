require 'date'
require_relative '../app/student'


begin
  
  student_1 = Student.new("Kit", "Anthon", Date.new(2015, 4, 5))
  student_2 = Student.new("Kuchak", "Kolya", Date.new(2012, 3, 4))
  student_3 = Student.new("Vovk", "Volodya", Date.new(2013, 3, 4))
  student_4 = Student.new("Vovk", "Volodya", Date.new(2024, 10, 30))

  
  puts "#{student_1.surname} #{student_1.name} is #{student_1.calculate_age} years old."
  puts "#{student_2.surname} #{student_2.name} is #{student_2.calculate_age} years old."
  puts "#{student_3.surname} #{student_3.name} is #{student_3.calculate_age} years old."
  puts "#{student_4.surname} #{student_4.name} is #{student_4.calculate_age} years old."
  puts


  Student.add_student("Dub","Vasya", Date.new(2015, 4, 6))
  
  puts "all_students"
  Student.all_students.each{|student| puts student}
  puts

  puts "get_students_by_age", Student.get_students_by_age(9)
  puts
  puts "get_students_by_name", Student.get_students_by_name("Volodya")



  rescue ArgumentError => e
      puts "Error add new student: #{e.message}"
  rescue NoMethodError => e
      puts "Error add new student: #{e.message}"
end