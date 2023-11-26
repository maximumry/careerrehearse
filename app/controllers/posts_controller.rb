class PostsController < ApplicationController
  before_action :user_match, only: [:edit, :update, :destroy]
  def index
    @posts = Post.order("created_at DESC")
  end

  def new
    @post_form = PostForm.new
  end

  def create
    @post_form = PostForm.new(post_form_params)
    if @post_form.valid?
       @post_form.save
       redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    post_attributes = @post.attributes
    @post_form = PostForm.new(post_attributes)
    @post_form.tag_name = @post.tags.first&.tag_name
  end

  def update
    @post_form = PostForm.new(post_form_params)
    @post = Post.find(params[:id])
    @post_form.video ||= @post.video.blob
    if @post_form.valid?
      @post_form.update(post_form_params, @post)
      redirect_to post_path(@post.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def search_tag
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end


  private
  def post_form_params
    params.require(:post_form).permit(:title, :description, :video, :industry_id, :tag_name).merge(user_id: current_user.id)
  end

  def user_match
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to root_path
    end
  end
end
