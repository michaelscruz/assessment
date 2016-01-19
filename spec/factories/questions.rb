FactoryGirl.define do
  factory :question do
    sequence(:text) { |n| "What is #{n} + #{n}?" } 
    type "multiple_choice"
    long_answer nil
    exam { FactoryGirl.create(:exam) }
  end

end
