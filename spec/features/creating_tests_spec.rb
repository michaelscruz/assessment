require 'rails_helper'
require 'helper_methods'
include HelperMethods

RSpec.describe "CreatingTests", type: :feature do
  feature "clicking 'Create a test' from the home page" do
    before { visit root_url }

    scenario "should take visitor to the test creation page" do
      click_link "Create a test"

      expect(page).to have_title "Create a Test"
      expect(page).to have_field "Name"
      expect(page).to have_field "Description"
      expect(page).to have_field "First name"
      expect(page).to have_field "Last name"
      expect(page).to have_field "Email"
      expect(page).to have_field "Password"
      expect(page).to have_field "Password confirmation"
      expect(page).to have_field "Subdomain"
    end
  end
end
