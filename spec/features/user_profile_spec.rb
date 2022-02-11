require "rails_helper"

RSpec.describe "Verify profile displaying", type: :feature do
  before(:each) do
    @user = create :user
    @post1 = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @post2 = create(:post, content: "Post#2", created_at: 5.minutes.ago, user: @user)
  end

  it "for a user with 2 posts" do
    visit user_path(@user)
    expect(page).to have_selector(".user-avatar")
    expect(page).to have_text("Test User")
    expect(page).to have_text("Email: #{@user.email}")
    expect(page).to have_text("About: #{@user.about}")
    expect(page).to have_text("Posts count: #{@user.posts.count}")
    expect(page).to have_selector("[id ^= 'post']", count: 2)
    expect(page).to have_text(@post1.content)
    expect(page).to have_text(@post2.content)
  end
end
