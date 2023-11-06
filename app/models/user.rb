class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    follower =  passive_relationships.find_by(following_id: user.id)
    return follower.present?
  end

  validates :password, length: {minimum: 16, message: "is too short (minimum is 16 characters)"}, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "is invalid. Include both letters and numbers" }
  validates :username, presence: true, length: {maximum: 15, message: "is too long (maximum is 15 characters)"}, format: { with: /\A[a-zA-Zぁ-んァ-ヶ一-龥々ー]+\z/, message: "only accepts English letters, Hiragana, Katakana, and Kanji" }
end
