require "rails_helper"

RSpec.describe "User can", type: :feature do
  before(:each) do
    @user = create :user
    @anton = create(:user, full_name: "Test Anton", email: "anton@example.com")
    @ivan = create(:user, full_name: "Test Ivan", email: "ivan@example.com")
    @user.follow(@anton)
    @user.follow(@ivan)
    @anton.follow(@user)
  end

  it "view his followings" do
    login_as(@user)
    visit following_user_path(@user)
    expect(page).to have_selector(".user-card", count: 2)
    expect(page).to have_button("Unfollow", count: 2)
    expect(page).to have_text("Test Anton")
    expect(page).to have_text("Test Ivan")
  end

  it "view his followers" do
    login_as(@user)
    visit followers_user_path(@user)
    expect(page).to have_selector(".user-card", count: 1)
    expect(page).to have_text("Test Anton")
  end
end
