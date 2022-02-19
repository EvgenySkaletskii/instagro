class Comment < ApplicationRecord
  default_scope -> { order(created_at: :asc) }
  belongs_to :user
  belongs_to :post
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
