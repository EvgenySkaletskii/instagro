class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:member, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :posts, dependent: :destroy

  #get follows (you are follower)
  has_many :given_follows, class_name: "Follow",
                           foreign_key: "follower_id",
                           dependent: :destroy
  #get start (you are follower)
  has_many :following, through: :given_follows, source: :followed

  validates :full_name, presence: true, length: { maximum: 50 }
  validates :about, length: { maximum: 190 }

  def set_default_role
    self.role ||= :user
  end

  def feed
    Post.where("user_id = ?", id)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end
end
