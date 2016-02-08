# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  created_at  :datetime
#  updated_at  :datetime
#  value_min   :integer
#  value_max   :integer
#

FactoryGirl.define do
  factory :category_report do
    category { FactoryGirl.create :category }
    text "MyText"
    sequence(:value_key) { |n| n % 5 }
  end

end
