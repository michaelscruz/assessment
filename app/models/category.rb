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

  validates_presence_of :name, :exam

  def name_to_symbol
    self.name.gsub(' ', '_').to_sym
  end

  def id_name_with_underscores
    "category_" + self.name.gsub(' ', '_')
  end
end
