require "rails_helper"

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = create :user
    @post = @user.posts.create(content: "Lorem ipsum")
    @comment = @post.comments.build(content: "Comment#1", user_id: @user.id)
  end

  it "comment should be valid" do
    expect(@comment).to be_valid
  end

  it "content should be present" do
    @comment.content = ""
    expect(@comment).to_not be_valid
  end

  it "user id should be present" do
    @comment.user_id = nil
    expect(@comment).to_not be_valid
  end

  it "post id should be present" do
    @comment.post_id = nil
    expect(@comment).to_not be_valid
  end

  it "content should be at most 140 characters" do
    @comment.content = "a" * 141
    expect(@comment).to_not be_valid
  end
end
