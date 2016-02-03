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

require 'rails_helper'

RSpec.describe AccountsController, type: :controller do

end
