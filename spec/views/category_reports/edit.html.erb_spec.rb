require 'rails_helper'

RSpec.describe "category_reports/edit", type: :view do
  before(:each) do
    @category_report = assign(:category_report, CategoryReport.create!())
  end

  it "renders the edit category_report form" do
    render

    assert_select "form[action=?][method=?]", category_report_path(@category_report), "post" do
    end
  end
end
