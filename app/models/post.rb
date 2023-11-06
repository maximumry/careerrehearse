class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :comments
  has_many :likes
  belongs_to :industry
  belongs_to :user
  has_one_attached :video

  validates :industry_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :description, presence: true
  validates :title, presence: true, length: { maximum: 50, message: "is too long (maximum is 50 characters)"}
  validates :video, presence: true

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end