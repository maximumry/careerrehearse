class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :industry
  belongs_to :user
  has_one_attached :video

  validates :industry_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :description, presence: true
  validates :title, presence: true
end
