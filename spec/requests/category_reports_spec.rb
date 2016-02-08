require 'rails_helper'

RSpec.describe "CategoryReports", type: :request do
  describe "GET /category_reports" do
    it "works! (now write some real specs)" do
      get category_reports_path
      expect(response).to have_http_status(200)
    end
  end
end
