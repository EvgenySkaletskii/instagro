require "rails_helper"

RSpec.describe Follow, type: :model do
  before(:each) do
    @ivan = create(:user, email: "ivan@example.com")
    @anton = create(:user, email: "anton@example.com")
    @follow = Follow.create(follower_id: @ivan.id, followed_id: @anton.id)
  end

  it "should be valid" do
    expect(@follow).to be_valid
  end

  it "should require follower_id" do
    @follow.follower_id = nil
    expect(@follow).to_not be_valid
  end

  it "should require followed_id" do
    @follow.followed_id = nil
    expect(@follow).to_not be_valid
  end
end
