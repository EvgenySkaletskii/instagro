require "rails_helper"

describe "User signs in", type: :system do
  before do
    @user = create :user
    visit new_user_session_path
  end

  scenario "valid with correct credentials" do
    fill_in "user_email", with: @user.email
    fill_in "user_password", with: @user.password
    click_button "Log in"
    expect(page).to have_text "Signed in successfully."
    expect(page).to have_current_path("/users/1")
    #signed in user should be redirected to users page when opening root
    click_link "Home"
    expect(page).to have_current_path("/users/1")
    #user can logout
    click_on "Settings"
    click_link "Logout"
    expect(page).to have_current_path("/")
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