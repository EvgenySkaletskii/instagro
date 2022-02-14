require "rails_helper"

RSpec.describe PostsController, type: :controller do
  before(:each) do
    @user = create :user
    @admin = create :admin
    @post = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @new_post = build(:post, content: "Post#2", user: @user)
  end

  it "should create a new post with valid params" do
    sign_in @user
    expect do
      post :create, params: { post: { content: "new post", user_id: @user.id } }
    end.to change { Post.count }.by(1)
    expect(response).to redirect_to(feed_path)
  end

  it "should redirect create when not logged in" do
    expect do
      post :create, params: { post: { content: "new post", user_id: @user.id } }
    end.to_not change { Post.count }
    expect(response).to redirect_to(new_user_session_path)
  end

  it "should redirect destory when not logged in" do
    expect do
      delete :destroy, params: { id: @post.id }
    end.to_not change { Post.count }
    expect(response).to redirect_to(new_user_session_path)
  end

  it "should allow admins to edit member's post" do
    sign_in @admin
    put :update, { id: @post.id, content: "updated content" }
    expect(response).to be_success
  end
end
