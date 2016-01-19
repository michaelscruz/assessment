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
end
