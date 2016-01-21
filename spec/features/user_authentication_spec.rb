require 'rails_helper'

RSpec.describe "UsersPages", type: :feature do
  scenario "signing up" do
    visit root_url
    click_link "Sign up"

    expect(page).to have_title "Sign up"
  end
end
