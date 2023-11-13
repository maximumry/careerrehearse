class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :comments
  has_many :likes
  belongs_to :industry
  belongs_to :user
  has_one_attached :video

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "industry_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end
end