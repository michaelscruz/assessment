require 'rails_helper'
require 'helper_methods'
include HelperMethods

RSpec.describe "CreatingTests", type: :feature do
  feature "Creating a new test without an account" do
    before { @user = create_signed_in_user }

    scenario "clicking 'Create a test' should bring user to subdomain creation page" do 
      click_link "Create a test" 

      expect(page).to have_title "Create a Subomain"
      expect(page).to have_field "Subdomain"
    end
  end
      # expect(page).to have_field "Name"
      # expect(page).to have_field "Description"
      # expect(page).to have_button "Next"
      # expect(page).to have_field "First name"
      # expect(page).to have_field "Last name"
      # expect(page).to have_field "Email"
      # expect(page).to have_field "Password"
      # expect(page).to have_field "Password confirmation"
end