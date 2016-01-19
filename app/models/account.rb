# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  subdomain  :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Account < ActiveRecord::Base
  belongs_to :user
  has_many :exams, dependent: :destroy

  validates_presence_of :name, :subdomain, :user
end
