require_relative 'test_helper'

Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new(
  reports_dir: 'test/reports/spec', 
  report_filename: 'spec_test_results.html',
  add_timestamp: true,
  color: true,                
  slow_count: 5,            
  detailed_skip: true,      
  slow_threshold: 5,         
  show_slow_tests: true     
)

class StudentSpec < Minitest::Spec
  describe Student do
    before do
        Student.clear_all_students 
        @date_of_birth = Date.new(2000, 1, 1)
        @student = Student.add_student('Kozak', 'Sasha', @date_of_birth) 
      end

    it 'initializes with correct attributes' do
      _(@student.surname).must_equal 'Kozak'
      _(@student.name).must_equal 'Sasha'
      _(@student.date_of_birth).must_equal @date_of_birth
    end

    it 'calculates age correctly' do
      expected_age = Date.today.year - @date_of_birth.year
      expected_age -= 1 if @date_of_birth.month > Date.today.month || (@date_of_birth.month == Date.today.month && @date_of_birth.day > Date.today.day)
      _(@student.calculate_age).must_equal expected_age
    end

    it 'adds a student correctly' do
      new_student = Student.add_student('Dub', 'Nazar', Date.new(1995, 5, 15))
      _(Student.all_students.size).must_equal 2
      _(new_student.surname).must_equal 'Dub'
      _(new_student.name).must_equal 'Nazar'
    end

    it 'prevents adding duplicate students' do
      _{ Student.add_student('Kozak', 'Sasha', @date_of_birth) }.must_raise(StandardError)
    end

    it 'removes a student' do
      Student.remove_student(@student)
      _(Student.all_students.size).must_equal 0
    end

    it 'gets students by age' do
      Student.add_student('Dub', 'Nazar', Date.new(1995, 5, 15))
      _(Student.get_students_by_age(@student.calculate_age).size).must_equal 1
    end

    it 'validates date of birth' do
      _{ Student.new('Kozak', 'Sasha', Date.today + 1) }.must_raise(ArgumentError)
      _{ Student.new('Kozak', 'Sasha', Date.today) }.must_raise(NoMethodError)
    end
  end
end
