def create_multiple_choice_tests(number_of_tests)
  number_of_tests.times do 
    FactoryGirl.create :multiple_choice_exam_with_three_questions
  end
end
