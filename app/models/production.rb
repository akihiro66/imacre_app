class Production < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :logs, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :tips, length: { maximum: 50 }
  validates :popularity,
            :numericality => {
              :only_interger => true,
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 5,
            },
            allow_nil: true

  def feed_comment(production_id)
    Comment.where("production_id = ?", production_id)
  end

  # 作品に付属するログのフィードを作成
  def feed_log(production_id)
    Log.where("production_id = ?", production_id)
  end

  private

    # アップロードされた画像のサイズを制限する
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "：5MBより大きい画像はアップロードできません。")
      end
    end
end
