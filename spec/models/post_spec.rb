require "rails_helper"

RSpec.describe Post, type: :model do
  before(:each) do
    @user = create :user
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  it "post should be valid" do
    expect(@post).to be_valid
  end

  it "user id should be present" do
    @post.user_id = nil
    expect(@post).to_not be_valid
  end

  it "content should be present" do
    @post.content = ""
    expect(@post).to_not be_valid
  end

  it "content should be at most 140 characters" do
    @post.content = "a" * 141
    expect(@post).to_not be_valid
  end

  it "order should be most recent first" do
    post1 = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    post2 = create(:post, content: "Post#2", user: @user)
    expect(Post.first).to eq(post2)
  end
end
