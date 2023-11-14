class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :comments
  has_many :likes
  has_many :post_tag_relations
  has_many :tags, through: :post_tag_relations
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