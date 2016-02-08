require 'rails_helper'

RSpec.describe "category_reports/index", type: :view do
  before(:each) do
    assign(:category_reports, [
      CategoryReport.create!(),
      CategoryReport.create!()
    ])
  end

  it "renders a list of category_reports" do
    render
  end
end
