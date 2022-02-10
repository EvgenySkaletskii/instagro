require "rails_helper"

RSpec.describe "User signs up", type: :system do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password(min_length: 8) }

  before(:all) do
    @user = build :user
  end

  before(:each) do
    visit new_user_registration_path
  end

  scenario "with valid data" do
    fill_in "user_full_name", with: @user.full_name
    fill_in "user_email", with: email
    fill_in "user_about", with: @user.about
    fill_in "user_password", with: password
    fill_in "user_password_confirmation", with: password
    find('input[value="Sign up"]').click
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(current_path).to include("/users/")
  end

  scenario "invalid when email already exists" do
    fill_in "user_full_name", with: @user.full_name
    fill_in "user_email", with: @user.email
    fill_in "user_about", with: @user.about
    fill_in "user_password", with: @user.password
    fill_in "user_password_confirmation", with: @user.password_confirmation
    find('input[value="Sign up"]').click
    expect(page).to have_no_text "Welcome! You have signed up successfully."
    expect(page).to have_text "Email has already been taken"
  end

  scenario "invalid without filling form" do
    find('input[value="Sign up"]').click
    expect(page).to have_no_text "Welcome! You have signed up successfully."
    expect(page).to have_text "3 errors prohibited this user from being saved:"
  end
end
