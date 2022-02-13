class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def destroy?
    (user.admin? && post.user.posts.count < 10) || user.posts.find_by(id: post.id)
  end
end
