require 'rails_helper'

RSpec.describe "UserPages", type: :request do
  
  subject { page }

  describe "signing up" do
    before do
      visit root_url
      click_link "Sign up"
    end

    it { should have_title "Sign up" }

    describe "filling in fields" do
      before do
        fill_in "First name", with: "Bob"
        fill_in "Last name", with: "Bobbingsly"
        fill_in "Email", with: "bob@example.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Sign up"
      end

      it { should have_content "Welcome! You have signed up successfully." }
      it { should have_title "Bob Bobbingsly" }
    end
  end
end
