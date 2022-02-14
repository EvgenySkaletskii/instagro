require "rails_helper"

RSpec.describe "Posts", type: :request do
  before(:each) do
    @user = create :user
    @admin = create :admin
    @post = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @new_post = build(:post, content: "Post#2", user: @user)
  end

  it "should allow admins to edit member's post" do
    login_as @admin
    put post_path(@post), params: { post: { content: "updated content" } }
    expect(@user.posts.find_by(id: @post.id).content).to eq("updated content")
  end

  it "should allow admins to delete member's post" do
    login_as @admin
    expect do
      delete post_path(@post)
    end.to change { Post.count }.by(-1)
    expect(@user.posts.count).to eq(0)
  end
end
