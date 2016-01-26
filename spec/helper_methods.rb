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

  def create_signed_in_user(options={})
    user = FactoryGirl.create :user

    if options[:account]
      account = Account.create!(name: user.full_name, subdomain: user.first_name + "_" + user.last_name, user: user)
      user.account = account
    end
    
    sign_in_test_user(user)
    user
  end

  def fill_in_user_fields(email, password, password_confirmation=nil, first_name=nil, last_name=nil, current_password=nil)
    fill_in "First name", with: first_name if first_name
    fill_in "Last name", with: last_name if last_name
    fill_in "Email", with: email
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password_confirmation if password_confirmation
    fill_in "Current password", with: current_password if current_password
  end

  def create_tests(number_of_tests)
    number_of_tests.times do 
      FactoryGirl.create :exam
    end
  end
end