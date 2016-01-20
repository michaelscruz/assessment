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

class Exam < ActiveRecord::Base
  belongs_to :account
  has_many :scores, dependent: :destroy
  has_many :users, through: :scores
  has_many :reports, dependent: :destroy 
  
  EXAM_TYPES = ["multiple_choice", "long_answer", "mixed"]

  validates_presence_of :account
  validates :type, presence: true, inclusion: { in: EXAM_TYPES }
  validates :name, presence: true, length: { in: 4..50 }
  validates :description, :presence => true
end
