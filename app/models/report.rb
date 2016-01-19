# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  text       :text
#  user_id    :integer
#  exam_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
end
