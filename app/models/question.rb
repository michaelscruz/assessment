# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  text          :string(255)
#  question_type :string(255)
#  long_answer   :text
#  exam_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  category_id   :integer
#

class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :exam
  has_many :answers, :inverse_of => :question

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :category, reject_if: :all_blank
  
  QUESTION_TYPES = ["multiple_choice", "long_answer"]
  validates_presence_of :exam
  validates_presence_of :category, if: :multiple_choice?
  validates :question_type, presence: true, inclusion: { in: QUESTION_TYPES }
  #validates_presence_of :category, if: :multiple_choice?

  def multiple_choice?
    self.question_type == "multiple_choice"
  end

  def has_category?
    !self.category.nil? && Category.find_by(id: self.category_id)
  end

  def blank?
    if multiple_choice?
      return self.text.blank? && self.answers.empty? && self.category.nil?
    else
      return self.text.blank?
    end
  end

  def set_type
    self.question_type = self.exam.exam_type
  end

  def set_category(existing_category_name, new_category_name)
    if existing_category_name.blank? && !new_category_name.blank?
      new_category = Category.new(name: new_category_name, exam: self.exam)
      new_category.save
      self.category = new_category
    elsif !existing_category_name.blank?
      self.category = Category.find_by(name: existing_category_name, exam: self.exam)
    end
  end
end
