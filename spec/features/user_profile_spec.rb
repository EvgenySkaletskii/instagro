require "rails_helper"

RSpec.describe "User profile page", type: :feature do
  before(:each) do
    @user = create :user
    @post1 = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @post2 = create(:post, content: "Post#2", created_at: 5.minutes.ago, user: @user)
    @anton = create(:user, full_name: "Test Anton", email: "anton@example.com")
    @post3 = create(:post, content: "Post#3", user: @anton)
  end

  it "displays user own stats and posts" do
    login_as(@user)
    visit user_path(@user)
    #display stats
    expect(page).to have_selector(".user-avatar")
    expect(page).to have_text("Test User")
    expect(page).to have_text("Email: #{@user.email}")
    expect(page).to have_text("#{@user.about}")
    #display post form
    expect(page).to have_text("Posts count: #{@user.posts.count}")
    #display posts
    expect(page).to have_selector(".post-form")
    expect(page).to have_selector(".posts [id ^= 'post']", count: 2)
    expect(page).to have_text(@post1.content)
    expect(page).to have_text(@post2.content)
    #follow button
    expect(page).not_to have_selector("#follow-button")
  end

  it "displays other user stats and posts" do
    login_as(@user)
    visit user_path(@anton)
    #display stats
    expect(page).to have_selector(".user-avatar")
    expect(page).to have_text("Test Anton")
    expect(page).to have_text("Email: #{@anton.email}")
    expect(page).to have_text("#{@anton.about}")
    expect(page).to have_text("Posts count: #{@anton.posts.count}")
    #do not display form
    expect(page).not_to have_selector(".post-form")
    #display posts
    expect(page).to have_selector(".posts [id ^= 'post']", count: 1)
    expect(page).to have_text(@post3.content)
    #display follow button
    expect(page).to have_button("Follow")
  end

  it "displays user followings and followers" do
    @user.follow(@anton)
    login_as(@user)
    visit user_path(@user)
    expect(page).to have_text("1 following")
    expect(page).to have_text("0 followers")
    visit user_path(@anton)
    expect(page).to have_text("0 following")
    expect(page).to have_text("1 followers")
    expect(page).to have_button("Unfollow")
  end

  it "allows user to follow and unfollow other user" do
    login_as(@user)
    visit user_path(@anton)
    expect do
      click_button("Follow")
    end.to change { @user.following.count }.by(1).and change { @anton.followers.count }.by(1)
    expect do
      click_button("Unfollow")
    end.to change { @user.following.count }.by(-1).and change { @anton.followers.count }.by(-1)
    expect(page).to have_button("Follow")
  end
end
