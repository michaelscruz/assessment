class Question < ActiveRecord::Base
  belongs_to :exam
  has_many :answers
  
  QUESTION_TYPES = ["multiple_choice", "long_answer"]
  validates_presence_of :exam
  validates :type, presence: true, inclusion: { in: QUESTION_TYPES }
end
