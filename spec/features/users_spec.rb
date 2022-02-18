require "rails_helper"

RSpec.describe "Users page", type: :feature do
  before(:each) do
    @user = create :user
    @anton = create(:user, full_name: "Test Anton", email: "anton@example.com")
    @ivan = create(:user, full_name: "Test Ivan", email: "ivan@example.com")
  end

  it "should be unavailable for not logged in users" do
    visit users_path
    expect(page).to have_text("You need to sign in or sign up before continuing.")
    expect(page).to have_button("Log in")
  end

  it "should display all users" do
    login_as(@user)
    visit users_path
    expect(page).to have_selector(".user-card", count: 2)
    expect(page).to have_text("Test Anton")
    expect(page).to have_text("Test Ivan")
  end

  it "allows user to follow - unfollow" do
    login_as(@user)
    visit users_path
    expect do
      click_button("Follow", match: :first)
    end.to change { @user.following.count }.by(1)
    expect do
      click_button("Unfollow")
    end.to change { @user.following.count }.by(-1)
  end
end
