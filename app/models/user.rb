class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:member, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  #RELATIONS
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  #get follows (you are follower)
  has_many :given_follows, class_name: "Follow",
                           foreign_key: "follower_id",
                           dependent: :destroy
  #get start (you are follower)
  has_many :following, through: :given_follows, source: :followed

  #get received_follows (you are star)
  has_many :received_follows, class_name: "Follow",
                              foreign_key: "followed_id",
                              dependent: :destroy
  #get followers (you are star)
  has_many :followers, through: :received_follows, source: :follower

  #VALIDATIONS
  validates :full_name, presence: true, length: { maximum: 50 }
  validates :about, length: { maximum: 190 }

  #SCOPES
  scope :all_except, ->(user) { where.not(id: user) }

  def set_default_role
    self.role ||= :user
  end

  def feed(user)
    #Post.where("user_id = ?", id)
    Post.where(user_id: user.following.ids << user.id)
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
