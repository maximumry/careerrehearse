class PostForm
  include ActiveModel::Model

  attr_accessor(:title, :description, :video, :industry_id, :user_id, :id, :created_at, :updated_at, :tag_name) 
  with_options presence: true do
    validates :industry_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :description
    validates :title, length: { maximum: 50, message: "is too long (maximum is 50 characters)"}
    validates :video
  end

  def save
  post = Post.create(title: title, video: video, description: description, industry_id: industry_id, user_id: user_id)

  if tag_name.present?
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save
    PostTagRelation.create(post_id: post.id, tag_id: tag.id)
  end
end

  def update(params, post)
    post.post_tag_relations.destroy_all

    tag_name = params.delete(:tag_name)

    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

    tag.save if tag_name.present?
    post.update(params)
    PostTagRelation.create(post_id: post.id, tag_id: tag.id) if tag_name.present?
  end
end