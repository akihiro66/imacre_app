class Comment < ApplicationRecord
  belongs_to :production
  validates :user_id, presence: true
  validates :production_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
