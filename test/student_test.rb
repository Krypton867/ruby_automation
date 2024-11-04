require_relative 'test_helper'

class StudentTest < Minitest::Test
  def setup
    Student.all_students.clear 
    @date_of_birth = Date.new(2000, 1, 1)
  end

  def test_student_initialization
    student = Student.new('Kozak', 'Sasha', @date_of_birth)
    assert_equal 'Kozak', student.surname
    assert_equal 'Sasha', student.name
    assert_equal @date_of_birth, student.date_of_birth
  end

  def test_calculate_age
    student = Student.new('Kozak', 'Sasha', @date_of_birth)
    age = Date.today.year - @date_of_birth.year
    age -= 1 if @date_of_birth.month > Date.today.month || (@date_of_birth.month == Date.today.month && @date_of_birth.day > Date.today.day)
    assert_equal age, student.calculate_age
  end

  def test_add_student
    student = Student.add_student('Dub', 'Nazar', Date.new(1995, 5, 15))
    assert_equal 1, Student.all_students.size
    assert_equal 'Dub', student.surname
    assert_equal 'Nazar', student.name
  end

  def test_prevent_duplicate_student
    Student.add_student('Kozak', 'Sasha', @date_of_birth)
    assert_raises(StandardError) do
      Student.add_student('Kozak', 'Sasha', @date_of_birth)
    end
  end

  def test_remove_student
    student = Student.add_student('Kozak', 'Sasha', @date_of_birth) 
    assert_includes Student.all_students, student, "Student should be added"

    Student.remove_student(student)
    assert_empty Student.all_students, "Students list should be empty after removal"
  end

  def test_get_students_by_age
    Student.add_student('Dub', 'Nazar', Date.new(2017, 5, 15))
    assert_equal 1, Student.get_students_by_age(7).size 
  end

  def test_validate_date_of_birth
    assert_raises(ArgumentError) do
      Student.new('Kozak', 'Sasha', Date.today + 1)
    end
    assert_raises(NoMethodError) do
      Student.new('Kozak', 'Sasha', Date.today)
    end
  end
end
