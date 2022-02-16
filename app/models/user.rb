class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:member, :manager, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :posts, dependent: :destroy

  has_many :follows, class_name: "Follow",
                     foreign_key: "follower_id",
                     dependent: :destroy

  validates :full_name, presence: true, length: { maximum: 50 }
  validates :about, length: { maximum: 190 }

  def set_default_role
    self.role ||= :user
  end

  def feed
    Post.where("user_id = ?", id)
  end
end
