class PostForm
  include ActiveModel::Model

  attr_accessor :title, :description, :video, :industry_id, :user_id

  with_options presence: true do
    validates :industry_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :description
    validates :title, length: { maximum: 50, message: "is too long (maximum is 50 characters)"}
    validates :video
  end

  def save
    Post.create(title: title, video: video, description: description, industry_id: industry_id, user_id: user_id)
  end
end