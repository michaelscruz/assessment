class Question < ActiveRecord::Base
  belongs_to :category
  belongs_to :exam
  has_many :answers
  
  QUESTION_TYPES = ["multiple_choice", "long_answer"]
  validates_presence_of :exam
  validates :type, presence: true, inclusion: { in: QUESTION_TYPES }
  validates_presence_of :category, if: :multiple_choice?

  def multiple_choice?
    self.type == "multiple_choice"
  end

  def has_category?
    !self.category.nil? && Category.find_by(id: self.category_id)
  end
end
