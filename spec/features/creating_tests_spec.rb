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

  feature "Creating a new test with an existing account", js: true do
    before do
      @user = create_signed_in_user(account: true, no_capybara: true)
      visit user_path(@user)
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

      context "Adding an answer" do
        before { click_link "Add answer" }

        scenario "should bring up an answer form" do
          expect(page).to have_field "Answer text"
          expect(page).to have_field "Answer value"
          expect(page).to have_link "remove answer"
        end

        context "filling in the answer" do
          before do
            fill_in "Question text", with: "Here is my first question"
            fill_in "Answer text", with: "First option"
            fill_in "Answer value", with: 3
          end

          context "clicking Add answer again should add another answer" do 
            before { click_link "Add answer" }

            scenario "two answers" do
              expect(page).to have_field("Answer text", count: 2)
            end

            scenario "clicking next question should bring up a new question form" do
              click_button "Next question"

              expect(page).to have_title "New Question"
              expect(page).to have_field "Question text"
              expect(page).not_to have_field "Answer text"
            end

            scenario "clicking Finalize test should bring user to test show page" do 
              click_button "Finalize test"

              expect(page).to have_title "Sample Test"
            end
          end
        end
      end
    end
  end
end
