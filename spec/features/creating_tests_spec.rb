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

  feature "Creating a new test with an existing account" do 
    before do
      @user = create_signed_in_user(account: true)
      click_link "Create a test"
    end

    scenario "should bring user to new test form" do
      expect(page).to have_title "Create a Test"
    end

    context "filling out the form for a new multiple choice test" do 
      before do 
        fill_in "Name", with: "Sample Test"
        fill_in "Description", with: "This is a sample test. " * 50
        select "Multiple choice", from: "Type of test"
        click_button "Next"
      end

      scenario "should lead to a nex question form" do
        expect(page).to have_title "New Question"
      end
    end
  end
end
