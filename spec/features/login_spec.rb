require "rails_helper"

RSpec.describe "User signs in", type: :feature do
  before(:each) do
    @user = create :user
    visit new_user_session_path
  end

  scenario "valid with correct credentials" do
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Log in"
    expect(page).to have_text "Signed in successfully."
    expect(current_path).to include("/feed")
    #user can logout
    click_on "Settings"
    click_link "Logout"
    expect(page).to have_current_path("/feed")
    expect(page).to have_text "Signed out successfully."
    expect(page).to have_link "Sign in"
  end

  scenario "invalid with unregistered account" do
    fill_in "user_email", with: "azaza@example.com"
    fill_in "user_password", with: "FakePassword123"
    click_button "Log in"
    expect(page).to have_no_text "Signed in successfully."
    expect(page).to have_text "Invalid Email or password."
    expect(page).to have_no_link "Logout"
  end

  scenario "invalid with invalid password" do
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: "FakePassword123"
    click_button "Log in"
    expect(page).to have_no_text "Signed in successfully."
    expect(page).to have_text "Invalid Email or password."
    expect(page).to have_no_link "Logout"
  end
end
