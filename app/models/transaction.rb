class Transaction < ApplicationRecord
  belongs_to :user

  attr_accesor :token

  validates :price, presence: true
  validates :text, presence: true
end
