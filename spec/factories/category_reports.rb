FactoryGirl.define do
  factory :category_report do
    category { FactoryGirl.create :category }
    text "MyText"
    sequence(:value_key) { |n| n % 5 }
  end

end
