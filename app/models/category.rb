class Category < ActiveRecord::Base
  has_many :questions
  has_many :category_reports

  validates_presence_of :name
end
