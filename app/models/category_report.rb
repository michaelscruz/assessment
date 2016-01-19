# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  value_key   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class CategoryReport < ActiveRecord::Base
  belongs_to :category
end
