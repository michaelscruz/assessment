# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  value       :integer
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Answer < ActiveRecord::Base
  belongs_to :question, :inverse_of => :answers

  validates_presence_of :text, :value, :question

  def element_id(rails_generated_random_unpredictable_stupid_id)
    "answer_value_#{rails_generated_random_unpredictable_stupid_id}"
  end
end
