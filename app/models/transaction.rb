class Transaction < ApplicationRecord
  validates :price, presence: true
  validates :text, presence: true
end
