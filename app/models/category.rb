# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  exam_id    :integer
#

class Category < ActiveRecord::Base
  belongs_to :exam
  has_many :questions
  has_many :category_reports

  validates_presence_of :name
end
