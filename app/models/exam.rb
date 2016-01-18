class Exam < ActiveRecord::Base
  validates :name, presence: true, length: { in: 4..50 }
  validates :description, :presence => true
end
