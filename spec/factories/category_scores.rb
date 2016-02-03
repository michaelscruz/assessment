# == Schema Information
#
# Table name: category_scores
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  category_id :integer
#  score       :integer          default(0), not null
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :category_score do
    user
    category 
  end
end
