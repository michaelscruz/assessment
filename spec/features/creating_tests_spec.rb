require 'rails_helper'
require 'helper_methods'
include HelperMethods

RSpec.describe "CreatingTests", type: :feature do
  subject { page }

  describe "Creating a new test without an account" do
    before { @user = create_signed_in_user }

    scenario "clicking 'Create a test'" do 
      click_link "Create a test" 

      expect(page).to have_title "Create a Subdomain"
      expect(page).to have_field "Subdomain"
      expect(page).to have_field "Name"
      expect(page).to have_button "Next"
    end

    describe "creating an account" do 
      before do
        click_link "Create a test"
        fill_in("Name", with: "Bob's Domain")
        fill_in("Subdomain", with: "Bobs_subdomain")
        click_button "Next"
      end

      it "should bring user to new test form" do
        expect(page).to have_title "Create a Test"
        expect(page).to have_field "Name"
        expect(page).to have_field "Description"
        expect(page).to have_field "Type of test"
        expect(page).to have_button "Next"
      end
    end
  end

  describe "Creating a new test with an existing account" do
    before do
      @user = create_signed_in_user(account: true, no_capybara: true)
      visit user_path(@user)
      click_link "Create a test"
    end

    it { should have_title "Create a Test" }

    context "filling out the form for a new multiple choice test" do 
      before do 
        fill_in "Name", with: "Sample Test"
        fill_in "Description", with: "This is a sample test. " * 50
        select "Multiple choice", from: "Type of test"
        click_button "Next"
      end

      it "should lead to a nex question form" do
        expect(page).to have_title "New Question"
      end

      describe "Adding an answer", js: true do
        before { click_link "Add answer" }

        it "should bring up an answer form" do
          expect(page).to have_field "Question category"
          expect(page).to have_field "Answer text"
          expect(page).to have_field "Answer value"
          expect(page).to have_link "remove above answer"
        end

        describe "filling in the answer" do
          before do
            fill_in "Question text", with: "Here is my first question"
            fill_in "Answer text", with: "First option"
            fill_in "Answer value", with: 3
          end

          describe "clicking Add answer again should add another answer" do 
            before { click_link "Add answer" }

            it "should have two answers" do
              expect(page).to have_field("Answer text", count: 2)
            end

            scenario "clicking next question should bring up a new question form" do
              click_button "Next question"

              expect(page).to have_title "New Question"
              expect(page).to have_field "Question text"
              expect(page).not_to have_field "Answer text"
            end

            scenario "clicking Finalize test should bring user to test show page" do 
              page.accept_alert "Are you sure? This will finish adding questions to your test." do
                click_button "Finalize test"
              end

              expect(page).to have_title "Sample Test"
            end
          end
        end
      end
    end
  end
end
