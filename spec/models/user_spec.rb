require "rails_helper"

RSpec.describe User, type: :model do
  it "associated posts should be destroyed" do
    user = build :user
    user.save
    user.posts.create!(content: "Lorem ipsum")
    expect { user.destroy }.to change { Post.count }.by(-1)
  end

  it "should follow and unfollow user" do
    ivan = create(:user, email: "ivan@example.com")
    anton = create(:user, email: "anton@example.com")
    ivan.follow(anton)
    expect(ivan.following?(anton)).to be true
    ivan.unfollow(anton)
    expect(ivan.following?(anton)).to be false
  end
end
