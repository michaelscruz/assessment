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
  after_initialize :default_values

  belongs_to :exam
  belongs_to :user

  validates_presence_of :exam, :user

  private
    
    def default_values
      self.score = 0
      self.questions_answered = 0
    end
end
