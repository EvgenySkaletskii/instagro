require "rails_helper"

RSpec.describe PostsController do
  before(:all) do
    @user = create :user
    @post = create(:post, content: "Post#1", created_at: 10.minutes.ago, user: @user)
    @new_post = build(:post, content: "Post#2", user: @user)
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
end
