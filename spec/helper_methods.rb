include ApplicationHelper

module HelperMethods
  def sign_in_test_user(user, options={})
    if options[:no_capybara]
      sign_in_user(user)
    else
      visit root_url
      click_link "Sign in"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
    end
  end
end