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
#  type        :string(255)
#

FactoryGirl.define do
  factory :exam do
    sequence(:name) { |n| "Test#{n}" }
    description "Here is the description of this very revealing test."
    account { FactoryGirl.create :account }
  end

end
