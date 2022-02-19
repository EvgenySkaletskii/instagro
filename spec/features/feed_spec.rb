require "rails_helper"

RSpec.describe "Feed page", type: :feature do
  before(:each) do
    @member = create :user
    @manager = create :manager
    @admin = create :admin
    @post1 = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @member)
    @post2 = create(:post, content: "Post#2", created_at: 5.minutes.ago, user: @manager)
    @post3 = create(:post, content: "Post#3", created_at: 5.minutes.ago, user: @admin)
    @member.follow(@manager)
    @member.follow(@admin)
  end

  it "displays posts from followings)" do
    login_as(@member)
    visit feed_path
    expect(page).to have_selector(".posts [id ^= 'post']", count: 2)
    expect(page).to have_text("Post#2")
    expect(page).to have_text("Post#2")
    expect(page).not_to have_selector(".update-post-link")
    expect(page).not_to have_selector(".delete-post-link")
  end

  it "displays all posts for manager (can update own post)" do
    login_as(@manager)
    visit feed_path
    expect(page).to have_selector(".posts [id ^= 'post']", count: 3)
    expect(page).to have_selector(".update-post-link", count: 1)
    expect(page).to have_selector(".delete-post-link", count: 1)
  end

  it "displays all posts for admin (can update all posts)" do
    login_as(@admin)
    visit feed_path
    expect(page).to have_selector(".posts [id ^= 'post']", count: 3)
    expect(page).to have_selector(".update-post-link", count: 3)
    expect(page).to have_selector(".delete-post-link", count: 3)
  end

  it "allows user to create a post" do
    login_as(@member)
    visit feed_path
    fill_in "post_content", with: "New Post"
    click_on "Post"
    expect(page).to have_text("Post has been successfully created!")
    # expect(page).to have_text("New Post")
    # expect(page).to have_selector(".posts [id ^= 'post']", count: 2)
  end

  # it "allows user to update a post" do
  #   login_as(@member)
  #   visit feed_path
  #   click_on class: "update-post-link"
  #   fill_in "post_content", with: "Updated Post"
  #   click_on "Edit post"
  #   expect(page).to have_text("Post has been successfully updated!")
  #   expect(page).to have_selector(".posts [id ^= 'post']", count: 1)
  #   expect(page).to have_text("Updated Post")
  # end

  # it "allows user to delete a post" do
  #   login_as(@member)
  #   visit feed_path
  #   click_on class: "delete-post-link"
  #   expect(page).to have_text("Post has been successfully deleted!")
  #   expect(page).not_to have_selector(".posts [id ^= 'post']")
  # end
end
