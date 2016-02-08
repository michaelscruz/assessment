require 'rails_helper'

RSpec.describe "category_reports/new", type: :view do
  before(:each) do
    assign(:category_report, CategoryReport.new())
  end

  it "renders new category_report form" do
    render

    assert_select "form[action=?][method=?]", category_reports_path, "post" do
    end
  end
end
