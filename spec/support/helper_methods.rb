def create_multiple_choice_tests(number_of_tests)
  number_of_tests.times do 
    FactoryGirl.create :multiple_choice_exam_with_three_questions
  end
end

def create_a_new_test_with_capybara(user)
  visit user_path(user)
  click_link "Create a test"
  fill_in "Name", with: "Sample Test"
  fill_in "Description", with: "This is a sample test."
  select "Multiple choice", from: "Type of test"
  click_button "Next"
  click_link "Add answer"
  choose "Add new category"
  fill_in "New category", with: "First Category"
  fill_in "Question text", with: "Here is my first question"
  fill_in "Answer text", with: "First option"
  fill_in "Answer value", with: 3
  click_link "Add answer"
  page.all(:fillable_field, "Answer text").last.set("Second option")
  page.all(:fillable_field, "Answer value").last.set(-3)
  click_button "Next"
  click_link "Add answer"
  choose "Add new category"
  fill_in "New category", with: "Second Category"
  fill_in "Question text", with: "Here is my second question"
  fill_in "Answer text", with: "First option"
  fill_in "Answer value", with: 3
  click_link "Add answer"
  page.all(:fillable_field, "Answer text").last.set("Second option")
  page.all(:fillable_field, "Answer value").last.set(-3)
  click_button "Next"
  click_link "Add answer"
  choose "Add new category"
  fill_in "New category", with: "Third Category"
  fill_in "Question text", with: "Here is my third question"
  fill_in "Answer text", with: "First option"
  fill_in "Answer value", with: 3
  click_link "Add answer"
  page.all(:fillable_field, "Answer text").last.set("Second option")
  page.all(:fillable_field, "Answer value").last.set(-3)
  page.accept_alert "Are you sure? This will finish adding questions to your test." do
    click_button "Finalize test"
  end
end