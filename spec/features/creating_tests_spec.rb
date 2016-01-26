require 'rails_helper'
require 'helper_methods'
include HelperMethods

RSpec.describe "CreatingTests", type: :feature do
  feature "Creating a new test without an account" do
    before { @user = create_signed_in_user }

    scenario "clicking 'Create a test' should bring user to subdomain creation page" do 
      click_link "Create a test" 

      expect(page).to have_title "Create a Subdomain"
      expect(page).to have_field "Subdomain"
      expect(page).to have_field "Name"
      expect(page).to have_button "Next"
    end

    context "creating an account" do 
      before do
        click_link "Create a test"
        fill_in("Name", with: "Bob's Domain")
        fill_in("Subdomain", with: "Bobs_subdomain")
        click_button "Next"
      end

      scenario "should bring user to new test form" do
        expect(page).to have_title "Create a Test"
        expect(page).to have_field "Name"
        expect(page).to have_field "Description"
        expect(page).to have_field "Type of test"
        expect(page).to have_button "Next"
      end

    end

   end
      # expect(page).to have_field "First name"
      # expect(page).to have_field "Last name"
      # expect(page).to have_field "Email"
      # expect(page).to have_field "Password"
      # expect(page).to have_field "Password confirmation"
end
