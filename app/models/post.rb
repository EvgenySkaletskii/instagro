class Post < ApplicationRecord
  include ImageUploader::Attachment(:image) # adds an `image` virtual attribute
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likable
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
