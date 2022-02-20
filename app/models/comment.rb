class Comment < ApplicationRecord
  default_scope -> { order(created_at: :asc) }
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likable
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
