require 'rails_helper'

RSpec.describe "UsersPages", type: :feature do
  feature "signing up" do
    before do
      visit root_url
      click_link "Sign up"
    end

    scenario "should have 'Sign up' in title." do
      expect(page).to have_title "Sign up"
    end

    feature "filling out form and submitting" do
      before do
        fill_in "First name", with: "Bob"
        fill_in "Last name", with: "Bobbingsly"
        fill_in "Email", with: "bob@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"
      end

      scenario "should have 'Bob Bobbingsly' in the title" do
        expect(page).to have_title "Bob Bobbingsly"
      end
    end
  end
end
