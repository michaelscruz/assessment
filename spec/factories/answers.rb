# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  value       :integer
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :answer do
    sequence(:text) { |n| "Answer #{n}" }
    sequence(:value) { |n| (n % 5) - 2 }
    question
  end

end
