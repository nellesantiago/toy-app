class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = current_user.posts
  end

  def new
    @user = current_user
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    if @post.update(post_params)
      redirect_to user_posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
