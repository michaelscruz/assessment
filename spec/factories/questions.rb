# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  text          :string(255)
#  question_type :string(255)
#  long_answer   :text
#  exam_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  category_id   :integer
#

FactoryGirl.define do
  factory :question do
    sequence(:text) { |n| "What is #{n} + #{n}?" } 
    question_type "multiple_choice"
    long_answer nil
    exam
    category
  end

  factory :question_with_answers, :parent => :question do
    after(:build) do |question|
      question.category = FactoryGirl.create(:category, exam: question.exam)
      question.answers = create_list(:answer, 3, question: question)
    end
  end

  factory :questions_with_blank_category_with_answers, :parent => :question do
    after(:build) do |question|
      question.answers = create_list(:answer, 3, question: question)
    end
  end 
end
