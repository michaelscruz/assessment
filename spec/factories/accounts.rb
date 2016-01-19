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

FactoryGirl.define do
  factory :account do
    name "My Account"
    subdomain "example"
    user { FactoryGirl.create :user }
  end

end
