# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  account_id  :integer
#  exam_type   :string(255)
#

FactoryGirl.define do
  factory :exam do
    sequence(:name) { |n| "Test # #{n}" }
    description "Here is the description of this very revealing test."
    account { FactoryGirl.create :account }
    exam_type { "multiple_choice" }
  end

  factory :multiple_choice_exam_with_three_questions, :parent => :exam  do
    sequence(:name) { |n| "Multiple Choice Test ##{n}" }
    after(:build) do |exam|
      exam.questions = create_list(:question_with_answers, 1, exam: exam, category: nil)
      category = FactoryGirl.create(:category, exam: exam)
      exam.questions << create_list(:questions_with_blank_category_with_answers, 2, exam: exam, category: category)
    end
  end
end
