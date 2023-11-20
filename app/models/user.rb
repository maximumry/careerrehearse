class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :posts
  has_many :comments
  has_many :likes
  has_many :sns_credentials

  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    follower =  passive_relationships.find_by(following_id: user.id)
    return follower.present?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["username"]
  end

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      username: auth.info.name,
      email: auth.info.email
    )
  end

  validates :password, length: {minimum: 16, message: "is too short (minimum is 16 characters)"}, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "is invalid. Include both letters and numbers" }
  validates :username, presence: true, length: {maximum: 15, message: "is too long (maximum is 15 characters)"}, format: { with: /\A[a-zA-Zぁ-んァ-ヶ一-龥々ー]+\z/, message: "only accepts English letters, Hiragana, Katakana, and Kanji" }
end
