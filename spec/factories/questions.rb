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
    category { FactoryGirl.create :category }
    answers { create_list :answer, 3 }
  end
end
