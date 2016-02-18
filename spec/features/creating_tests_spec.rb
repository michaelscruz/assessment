require 'rails_helper'

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

      it "should bring user to Question #1 form" do
        expect(page).to have_title "New Question" 
        expect(page).to_not have_link "Add answer" 
        expect(page).to_not have_content "Question category" 
        expect(page).to have_content "Question #1" 
      end

      describe "selecting Finalize test with no questions added yet" do
        before { click_button "Finalize test" }

        it "should bring user back to new question form with an error" do 
        expect(page).to have_title "New Question" 
        expect(page).to have_content "error" 
        end
      end

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

        describe "selecting Finalize test with a blank question" do
          before { click_button "Finalize test" }

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

      describe "selecting Finalize test with no questions added yet" do
        before { click_button "Finalize test" }

        it "should bring them back to the new question form with an error message" do
          expect(page).to have_title "New Question" 
          expect(page).to have_content "error" 
        end
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

            describe "clicking next question", :new_question do
              before do
                click_button "Next question" 
              end

              it "should be on a new question form for Question 2" do
                expect(page).to have_title "New Question" 
                expect(page).to have_field "Question text" 
                expect(page).to have_content "Question #2"
                expect(page).to_not have_field "Answer text" 
                expect(page).to have_field "Sample Category" 
              end

              describe "selecting Finalize test with a blank question" do
                before do
                  page.accept_alert "Are you sure? This will finish adding questions to your test." do
                    click_button "Finalize test"
                  end
                end

                it { should have_title "Sample Test" }
              end
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

              it { should have_title "Results Reports" }
            end
          end
        end
      end
    end
  end

  describe "creating results reports for new tests", :results_reports, js: true do
    before do
      @user = create_signed_in_user(account: true, no_capybara: true)
      create_a_new_test_with_capybara(@user)
    end

    it "should display a proper category reports page" do
      expect(page).to have_title("Category Results")
      expect(page).to have_link("First Category")
      expect(page).to have_link("Second Category")
      expect(page).to have_link("Third Category")
    end

    describe "creating the reports" do 
      before { click_link "First Category" }

      it "should display a category_report form with the min value set and the range of possible values displayed" do
        expect(page).to have_title("Results Reports")
        expect(page).to have_content("from -3 to 3")
        expect(page).to have_content("Minimum value for this report: -3")
      end

      describe "filling out the form correctly for half of the possible range", :creating_first_report do
        before do
          fill_in("Maximum value for this report:", with: -1)
          fill_in("category_report_text", with: "This is a low score. You are terrible.")
          click_button "Next"
        end

        it "should display another category report form for the same category" do
          expect(page).to have_title("Results Reports")
          expect(page).to have_content("First Category")
          expect(page).to_not have_content("error")
        end
      end 
    end
  end
end
