require 'rails_helper'
require 'helper_methods'
include HelperMethods

RSpec.describe "UsersPages", type: :feature do
  feature "user authentication" do
    context "signing up" do
      before do
        visit root_url
        click_link "Sign up"
      end

      scenario "should have 'Sign up' in title." do
        expect(page).to have_title "Sign up"
      end

      scenario "should redisplay form with errors if form isn't correctly filled out" do
        fill_in "Email", with: "bob@examplecom"
        fill_in "Password", with: "bob"
        fill_in "Password confirmation", with: "bobspassword"
        click_button "Sign up"

        expect(page).to have_title "Sign up"
        expect(page).to have_content "First name can't be blank"
        expect(page).to have_content "Last name can't be blank"
        expect(page).to have_content "Password is too short"
        expect(page).to have_content "Password confirmation doesn't match Password"
        expect(page).to have_content "Email is invalid"
      end

      context "filling out form and submitting" do
        before do
          fill_in "First name", with: "Bob"
          fill_in "Last name", with: "Bobbingsly"
          fill_in "Email", with: "bob@example.com"
          fill_in "Password", with: "password"
          fill_in "Password confirmation", with: "password"
          click_button "Sign up"
        end

        scenario "should display the user's show page" do
          expect(page).to have_title "Bob Bobbingsly"
          expect(page).to have_link "Create a test"
          expect(page).to have_link "Take a test"
        end

        scenario "clicking profile and edit profile should take user to registrations edit page" do
          click_link "Bob Bobbingsly"
          click_link "Edit profile"

          expect(page).to have_title "Edit profile"
        end

        scenario "signing out" do
          click_link "Sign out"

          expect(page).to have_content "Signed out successfully"
          expect(page).to have_title "Home"
        end
      end
    end

    scenario "signing in should take user to their show page" do
      user = FactoryGirl.create :user 
      sign_in_test_user(user)

      expect(page).to have_title user.full_name
    end
  end
end
