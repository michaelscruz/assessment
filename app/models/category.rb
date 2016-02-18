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
  has_many :category_scores, dependent: :destroy

  validates_presence_of :name, :exam

  def name_to_symbol
    self.name.gsub(' ', '_').to_sym
  end

  def id_name_with_underscores
    "category_" + self.name.gsub(' ', '_')
  end

  def find_value_max
    @max_value = 0
    self.questions.each { |question| @max_value += question.answers.maximum(:value) }
    @max_value
  end

  def find_value_min
    @min_value = 0
    self.questions.each { |question| @min_value += question.answers.minimum(:value) }
    @min_value
  end

  def find_remaining_value_min
    @min_value = self.category_reports.maximum(:value_max)
    unless @min_value
      @min_value = 0
      self.questions.each { |question| @min_value += question.answers.minimum(:value) }
    end
    @min_value
  end
end
