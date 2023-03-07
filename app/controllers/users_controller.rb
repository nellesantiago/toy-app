class UsersController < ApplicationController
  before_action :authenticate_user, except: %i[new create]
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.where(role: "user")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:notice] = "Welcome, #{@user.first_name}!"
      redirect_to feed_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    if current_user.admin?
      redirect_to feed_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Account updated."
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if current_user.admin?
      @user.destroy
      flash[:notice] = "Account deleted."
      redirect_to users_path
    else
      log_out
      @user.destroy
      flash[:notice] = "Account deleted."
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
