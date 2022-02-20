require "rails_helper"

RSpec.describe "Verify likes: ", type: :feature do
  before(:each) do
    @user = create :user
    @admin = create(:admin)
    @post1 = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @comment = @post1.comments.create(content: "Comment#1", user_id: @user.id)
    @admin.follow(@user)
  end

  it "user like/dislike own post" do
    login_as(@user)
    visit feed_path
    #can like post
    expect do
      find(".post-likes .like-button").click
    end.to change { Like.count }.by(1)
    expect(page).to have_selector(".post-likes .like-counter", text: "1")
    expect(page).not_to have_selector(".post-likes .like-button")
    expect(page).to have_selector(".post-likes .dislike-button")
    #can dislike post
    expect do
      find(".post-likes .dislike-button").click
    end.to change { Like.count }.by(-1)
    expect(page).not_to have_selector(".post-likes .like-counter", text: "1")
    expect(page).not_to have_selector(".post-likes .dislike-button")
    expect(page).to have_selector(".post-likes .like-button")
  end

  it "user like/dislike own comment" do
    login_as(@user)
    visit feed_path
    #can like comment
    expect do
      find(".comment-likes .like-button").click
    end.to change { Like.count }.by(1)
    expect(page).to have_selector(".comment-likes .like-counter", text: "1")
    expect(page).not_to have_selector(".comment-likes .like-button")
    expect(page).to have_selector(".comment-likes .dislike-button")
    #can dislike post
    expect do
      find(".comment-likes .dislike-button").click
    end.to change { Like.count }.by(-1)
    expect(page).not_to have_selector(".comment-likes like-counter", text: "1")
    expect(page).not_to have_selector(".comment-likes .dislike-button")
    expect(page).to have_selector(".comment-likes .like-button")
  end

  it "user like/dislike following post" do
    login_as(@admin)
    visit feed_path
    #can like post
    expect do
      find(".post-likes .like-button").click
    end.to change { Like.count }.by(1)
    expect(page).to have_selector(".post-likes .like-counter", text: "1")
    expect(page).not_to have_selector(".post-likes .like-button")
    expect(page).to have_selector(".post-likes .dislike-button")
    #can dislike post
    expect do
      find(".post-likes .dislike-button").click
    end.to change { Like.count }.by(-1)
    expect(page).not_to have_selector(".post-likes .like-counter", text: "1")
    expect(page).not_to have_selector(".post-likes .dislike-button")
    expect(page).to have_selector(".post-likes .like-button")
  end

  it "user like/dislike following comment" do
    login_as(@admin)
    visit feed_path
    #can like comment
    expect do
      find(".comment-likes .like-button").click
    end.to change { Like.count }.by(1)
    expect(page).to have_selector(".comment-likes .like-counter", text: "1")
    expect(page).not_to have_selector(".comment-likes .like-button")
    expect(page).to have_selector(".comment-likes .dislike-button")
    #can dislike post
    expect do
      find(".comment-likes .dislike-button").click
    end.to change { Like.count }.by(-1)
    expect(page).not_to have_selector(".comment-likes like-counter", text: "1")
    expect(page).not_to have_selector(".comment-likes .dislike-button")
    expect(page).to have_selector(".comment-likes .like-button")
  end
end
