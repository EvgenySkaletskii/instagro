class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def destroy?
    user.admin? || user.posts.find(post.id)
  end
end
