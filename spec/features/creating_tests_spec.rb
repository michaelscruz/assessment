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

    describe "filling out the form for a new long answer test", :long_answer do
      before do
        fill_in "Name", with: "Sample Long Answer Test"
        fill_in "Description", with: "This a sample long answer test."
        select "Long answer", from: "Type of test"
        click_button "Next"
      end

      it { should have_title "New Question" }
      it { should_not have_link "Add answer" }
      it { should_not have_content "Question category" }
      it { should have_content "Question #1" }

      describe "creating a question" do
        before do
          fill_in "Question text", with: "What are your favorite words to type?"
          click_button "Next"
        end

        it { should have_content "Question #2" }

        describe "adding one more question and finalizing the test" do
          before do
            fill_in "Question text", with: "How do you feel about really short tests?"
            click_button "Finalize test"
          end

          it { should have_title "Sample Long Answer Test" }
        end
      end
    end

    describe "filling out the form for a new multiple choice test", :multiple_choice do 
      before do 
        fill_in "Name", with: "Sample Test"
        fill_in "Description", with: "This is a sample test."
        select "Multiple choice", from: "Type of test"
        click_button "Next"
      end

      it "should lead to a next question form" do
        expect(page).to have_title "New Question"
      end

      describe "Adding an answer", js: true do
        before do 
          click_link "Add answer" 
        end

        it "should bring up an answer form" do
          expect(page).to have_content "Question category"
          expect(page).to have_field "Answer text"
          expect(page).to have_field "Answer value"
          expect(page).to have_link "remove above answer"
        end

        describe "filling in the category and answer" do
          before do
            choose "Add new category"
            fill_in "New category", with: "Sample Category"
            fill_in "Question text", with: "Here is my first question"
            fill_in "Answer text", with: "First option"
            fill_in "Answer value", with: 3
          end

          describe "clicking Add answer again should add another answer" do 
            before do
              click_link "Add answer"
            end

            it { should have_field "Answer text", count: 2 }

            describe "clicking next question" do
              before do
                click_button "Next question" 
              end

              it { should have_title "New Question" }
              it { should have_field "Question text" }
              it { should_not have_field "Answer text" }
              it { should have_field "Sample Category" }
            end

            describe "not submitting a category for multiple choice test question", :no_category do 
              before do
                click_button "Next question"
                fill_in "Question text", with: "Here is my second question"
                click_link "Add answer"
                fill_in "Answer text", with: "First option"
                fill_in "Answer value", with: 2
                click_link "Add answer"
                page.all(:fillable_field, "Answer text").last.set("Second option")
                page.all(:fillable_field, "Answer value").last.set(-2)
                click_button "Next question"
              end

              it { should have_content "error" }
            end

            describe "clicking Finalize test" do 
              before do
                page.accept_alert "Are you sure? This will finish adding questions to your test." do
                  click_button "Finalize test"
                end
              end

              it { should have_title "Sample Test" }
            end
          end
        end
      end
    end
  end
end
