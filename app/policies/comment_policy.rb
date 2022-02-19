class CommentPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def edit?
    user.admin? || user.comments.find(comment.id)
  end

  def update?
    user.admin? || user.comments.find(comment.id)
  end

  def destroy?
    user.admin? || user.comments.find(comment.id)
  end
end
