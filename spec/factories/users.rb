FactoryGirl.define do
  
  factory :user do
    sequence(:first_name) { |n| "Person#{n}" }
    sequence(:last_name) { |n| "Someone#{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "password"
    password_confirmation "password"
  end

end
