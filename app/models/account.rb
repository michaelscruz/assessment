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
  before_save { self.subdomain.downcase! }
  
  belongs_to :user
  has_many :exams, dependent: :destroy

  validates_presence_of :user
  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9\-_]+\Z/, 
            :message => "only allows letters, numbers, dashes and underscores. Does not allow spaces." }
end
