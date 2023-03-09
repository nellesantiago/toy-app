class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = User.find(params[:user_id]).posts.order(created_at: :desc)
    @user = User.find(params[:user_id])
  end

  def new
    @user = current_user
    @post = current_user.posts.build
    if current_user.admin?
      redirect_to feed_path
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.html { redirect_to user_posts_path }
        format.turbo_stream { flash.now[:notice] = "Post created!" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.turbo_stream { flash.now[:notice] = "Post updated!" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.turbo_stream { flash.now[:notice] = "Post deleted!" }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, append_images: [])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
