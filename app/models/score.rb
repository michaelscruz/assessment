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

class Score < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user

  validates_presence_of :exam, :user
end
