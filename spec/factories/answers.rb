FactoryGirl.define do
  factory :answer do
    sequence(:text) { |n| "Answer #{n}" }
    sequence(:value) { |n| (n % 5) - 2 }
    question { FactoryGirl.create :question }
  end

end
