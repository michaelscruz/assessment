# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  text       :text
#  intro      :text
#  outro      :text
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :report do
    sequence(:text) { |n| "Report number #{n}." }
    user { FactoryGirl.create :user }
    exam { FactoryGirl.create :exam }
  end

end
