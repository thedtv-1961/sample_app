class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length:
    {maximum: Settings.micropost_content_max_length}
  mount_uploader :picture, PictureUploader
  validate :picture_size

  scope :newest, ->{order created_at: :desc}

  scope :follow_current_user, (lambda do |follower_ids, user_id|
    where(user_id: follower_ids).or(where user_id: user_id)
  end)

  private

  # Validates the size of an uploaded picture.
  def picture_size
    errors.add :picture, t("img_error", size: Settings.picture_size) if
      picture.size > Settings.picture_size.megabytes
  end
end
