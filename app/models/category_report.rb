# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  created_at  :datetime
#  updated_at  :datetime
#  value_min   :integer
#  value_max   :integer
#

class CategoryReport < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :text, :category
end
