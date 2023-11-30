class Transaction < ApplicationRecord
  belongs_to :user

  validates :price, presence: true
  validates :text, presence: true
end
