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
    Post.create(title: title, video: video, description: description, industry_id: industry_id, user_id: user_id)
    if tag_name.present?
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
    else
      PostTagRelation.create(post_id: post.id, tag_id: tag.id)
    end
  end

  def update(params, post)
    #一度タグの紐付けを消す
    post.post_tag_relations.destroy_all

    #paramsの中のタグの情報を削除。同時に、返り値としてタグの情報を変数に代入
    tag_name = params.delete(:tag_name)

    #もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

    #タグを保存
    tag.save if tag_name.present?
    post.update(params)
    PostTagRelation.create(post_id: post.id, tag_id: tag.id) if tag_name.present?
  end
end