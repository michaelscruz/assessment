require 'rails_helper'

RSpec.describe "TestTakingPages", type: :feature do
  describe "browsing tests from the home page without signing in" do
    before do
      create_multiple_choice_tests(3)
      visit root_url 
      click_link "Browse tests"
    end

    it "should show tests index" do
      expect(page).to have_title "Tests"
      expect(page).to have_link "Multiple Choice Test #", :count => 3
    end
  end

  describe "taking a test as a signed in user" do
    before do
      user = FactoryGirl.create :user
      sign_in_test_user(user)
    end

    scenario "clicking the 'Take a test' button" do
      click_link "Take a test"

      expect(page).to have_title "Tests"
    end 
  end
end
