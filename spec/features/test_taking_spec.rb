require 'rails_helper'
require 'helper_methods'
include HelperMethods

RSpec.describe "TestTakingPages", type: :feature do
  feature "browsing tests from the home page" do
    before { visit root_url }

    scenario "should show tests index" do
      click_link "Browse tests"

      expect(page).to have_title "Tests"
    end
  end

  feature "taking a test as a signed in user" do
    before do
      user = FactoryGirl.create :user
      sign_in_test_user(user)
    end

    scenario "clicking the 'Take a test' button" do
      click_link "Take a test"

      expect(page).to have_title "Tests"
    end

    context "with several tests in the db" do
      before { create_tests(5) }

      scenario "it should have 5 tests" do
        click_link "Take a test"
        
        expect(page).to have_content("Test # ", count: 5)
      end
    end
  end
end