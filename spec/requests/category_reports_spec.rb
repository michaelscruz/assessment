# == Schema Information
#
# Table name: category_reports
#
#  id          :integer          not null, primary key
#  category_id :integer
#  text        :text
#  value_key   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe "CategoryReports", type: :request do
  describe "GET /category_reports" do
    it "works! (now write some real specs)" do
      get category_reports_path
      expect(response).to have_http_status(200)
    end
  end
end
