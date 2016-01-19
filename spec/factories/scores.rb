# == Schema Information
#
# Table name: scores
#
#  id                 :integer          not null, primary key
#  score              :integer          default(0), not null
#  exam_id            :integer
#  user_id            :integer
#  questions_answered :integer          default(0), not null
#  created_at         :datetime
#  updated_at         :datetime
#

FactoryGirl.define do
  factory :score do
    score 0
    exam { FactoryGirl.create :exam }
    user { FactoryGirl.create :user }
    questions_answered 0
  end

end
