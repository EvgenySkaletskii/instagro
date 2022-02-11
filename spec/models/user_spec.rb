require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = build :user
  end

  it "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    expect { @user.destroy }.to change { Post.count }.by(-1)
  end
end
