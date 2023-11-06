class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  validates :password, length: {minimum: 16, message: "is too short (minimum is 16 characters)"}, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "is invalid. Include both letters and numbers" }
  validates :username, presence: true, length: {maximum: 15, message: "is too long (maximum is 15 characters)"}, format: { with: /\A[a-zA-Zぁ-んァ-ヶ一-龥々ー]+\z/, message: "only accepts English letters, Hiragana, Katakana, and Kanji" }
end
