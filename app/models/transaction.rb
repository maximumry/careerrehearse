class Transaction < ApplicationRecord
  belongs_to :user

  attr_accessor :token

  validates :price, presence: true
  validates :text, presence: true
end
