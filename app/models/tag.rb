class Tag < ApplicationRecord
  has_many :post_tag_relations
  has_many :posts, through: :post_tag_relations, dependent: :destroy

  validates :tag_name,  uniqueness: true
end
