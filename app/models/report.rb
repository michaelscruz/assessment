# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  text       :text
#  intro      :text
#  outro      :text
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  validates_presence_of :user, :exam
end
