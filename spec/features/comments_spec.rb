require "rails_helper"

RSpec.describe "Verify comments: ", type: :feature do
  before(:each) do
    @user = create :user
    @ivan = create(:user, email: "ivan@example.com")
    @post1 = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @ivan.follow(@user)
    @comment = @post1.comments.create(content: "Comment#1", user_id: @user.id)
  end

  it "user can create a comment to own post" do
    login_as(@user)
    visit feed_path
    expect(page).to have_text("Comment#1")
    fill_in "Comment...", with: "Comment#2"
    expect do
      click_button "Comment"
    end.to change { Comment.count }.by(1)
    expect(page).to have_text("Comment#2")
    expect(page).to have_selector("[id ^= 'comment']", count: 2)
    expect(page).to have_selector("[id ^= 'comment'] .update-link", count: 2)
    expect(page).to have_selector("[id ^= 'comment'] .delete-link", count: 2)
  end

  it "user can create a comment to user's post" do
    login_as(@ivan)
    visit feed_path
    expect(page).to have_text("Comment#1")
    fill_in "Comment...", with: "Comment#2"
    expect do
      click_button "Comment"
    end.to change { Comment.count }.by(1)
    expect(page).to have_text("Comment#2")
    expect(page).to have_selector("[id ^= 'comment']", count: 2)
    expect(page).to have_selector("[id ^= 'comment'] .update-link", count: 1)
    expect(page).to have_selector("[id ^= 'comment'] .delete-link", count: 1)
  end

  it "user can edit comment" do
    login_as(@user)
    visit feed_path
    find("[id ^= 'comment'] .update-link").click
    fill_in "comment_content", with: "Edited comment"
    click_button "Edit comment"
    expect(page).to have_text("Edited comment")
    expect(page).to have_selector("[id ^= 'comment']", count: 1)
  end

  it "user can delete comment" do
    login_as(@user)
    visit feed_path
    expect do
      find("[id ^= 'comment'] .delete-link").click
    end.to change { Comment.count }.by(-1)
    expect(page).not_to have_text("Comment#1")
    expect(page).not_to have_selector("[id ^= 'comment']")
  end
end
