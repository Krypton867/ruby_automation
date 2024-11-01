require 'date' 

class Student
    attr_accessor :surname, :name, :date_of_birth
    @@students = []
      

    def initialize(surname, name, date_of_birth)
      validate_date(date_of_birth)
      @surname = surname
      @name = name
      @date_of_birth = date_of_birth
      
      unless @@students.any? { |s| s.surname == surname || s.name == name || s.date_of_birth == date_of_birth}
        @@students << self
      end
    end
  

    def calculate_age
      current_year = Date.today.year
      age = current_year - @date_of_birth.year
      age -= 1 if @date_of_birth.month>Date.today.month || (@date_of_birth.month > Date.today.month && @date_of_birth.day >= Date.today.day)
      age
    end
  

    def self.add_student(surname, name, date_of_birth)
        student_exists = false
      
        @@students.each do |s|
          if s.surname == surname && s.name == name && s.date_of_birth == date_of_birth
            student_exists = true
            break  
          end
        end
      
        unless student_exists
          Student.new(surname, name, date_of_birth)  
        end
      end
      

      def self.remove_student(student)
        @@students.delete(student)
      end

      def self.get_students_by_age(age)
        @@students.select { |student| student.calculate_age == age }
      end
    
      def self.get_students_by_name(name)
        @@students.select { |student| student.name == name }
      end


      def self.all_students
        @@students
      end


      def to_s
        "#{@surname} #{@name}, Date of Birth: #{@date_of_birth}, Age: #{calculate_age}"
      end


      def validate_date(date_of_birth)
        if date_of_birth > Date.today
          raise ArgumentError, "date_of_birth can't be in future"
        end
        if date_of_birth == Date.today
          raise NoMethodError, "date_of_birth can't be today"
        end
      end

      private :validate_date

end