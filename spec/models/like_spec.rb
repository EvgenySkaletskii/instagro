require "rails_helper"

RSpec.describe Like, type: :model do
  before(:each) do
    @user = create :user
    @post = @user.posts.create(content: "Post#1")
    @comment = @user.comments.create(content: "Comment#1", post_id: @post.id)
    @post_like = @user.likes.build(likable_id: @post.id, likable_type: "Post")
    @comment_like = @user.likes.build(likable_id: @comment.id, likable_type: "Comment")
  end

  it "should be valid for posts" do
    expect(@post_like).to be_valid
  end

  it "should be valid for comments" do
    expect(@post_like).to be_valid
  end

  it "should require user_id" do
    @post_like.user_id = nil
    expect(@post_like).to_not be_valid
  end

  it "should require likable_id" do
    @post_like.likable_id = nil
    expect(@post_like).to_not be_valid
  end

  it "should require likable_type" do
    @post_like.likable_type = nil
    expect(@post_like).to_not be_valid
  end
end
