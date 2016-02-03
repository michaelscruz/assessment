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

    describe "clicking on a test" do 
      before { page.first(:link, "Multiple Choice Test").click }

      it "should be the test's show page" do
        expect(page).to have_title "Multiple Choice Test"
        expect(page).to have_text "Multiple Choice Test"
        expect(page).to have_text "Here is the description of this very revealing test."
        expect(page).to have_text "My account"
        expect(page).to have_text "Number of questions: 3"
      end

      describe "taking the test" do 
        before { click_link "Take this test" }

        it "should show the purchasing page(s)" do 
        end

        describe "purchasing the test" do

          it { should have_content "Question #1" }
          
          describe "answering the first question" do 

          end
        end
      end
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
