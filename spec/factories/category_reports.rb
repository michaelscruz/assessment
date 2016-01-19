# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  value_key   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :category_report do
    category { FactoryGirl.create :category }
    text "MyText"
    sequence(:value_key) { |n| n % 5 }
  end

end
