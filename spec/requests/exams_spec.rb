# == Schema Information
#
# Table name: exams
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  account_id  :integer
#  exam_type   :string(255)
#

require 'rails_helper'

RSpec.describe "Exams", type: :request do
end
