class AdminController < ApplicationController
  def index
    @posts = Post.all
    @users = User.where(role: "user")
  end
end
