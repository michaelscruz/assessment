require 'rails_helper'

RSpec.describe "category_reports/show", type: :view do
  before(:each) do
    @category_report = assign(:category_report, CategoryReport.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
