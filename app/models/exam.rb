# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Exam < ActiveRecord::Base
  validates :name, presence: true, length: { in: 4..50 }
  validates :description, :presence => true

  has_many :scores, dependent: :destroy
  has_many :users, through: :scores
end
