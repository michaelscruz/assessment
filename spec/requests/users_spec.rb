# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

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
