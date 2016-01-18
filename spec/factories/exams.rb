FactoryGirl.define do
  factory :exam do
    sequence(:name) { |n| "Test#{n}" }
    description "Here is the description of this very revealing test."
  end

end
