require "rails_helper"

RSpec.describe "User profile page", type: :feature do
  before(:each) do
    @user = create :user
    @post1 = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @post2 = create(:post, content: "Post#2", created_at: 5.minutes.ago, user: @user)
  end

  it "displays user posts" do
    login_as(@user)
    visit user_path(@user)
    expect(page).to have_selector(".user-avatar")
    expect(page).to have_text("Test User")
    expect(page).to have_text("Email: #{@user.email}")
    expect(page).to have_text("About: #{@user.about}")
    expect(page).to have_text("Posts count: #{@user.posts.count}")
    expect(page).to have_selector(".posts [id ^= 'post']", count: 2)
    expect(page).to have_text(@post1.content)
    expect(page).to have_text(@post2.content)
  end
end
