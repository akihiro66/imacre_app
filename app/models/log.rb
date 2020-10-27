class Log < ApplicationRecord
  belongs_to :production
  default_scope -> { order(created_at: :desc) }
  validates :production_id, presence: true
end
