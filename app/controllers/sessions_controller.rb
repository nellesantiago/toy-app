class SessionsController < ApplicationController
  def new
    if user_logged_in?
      redirect_to user_posts_path(current_user) if current_user.user?
      redirect_to feed_path if current_user.admin?
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      login(@user)
      if @user.admin?
        redirect_to feed_path
        return
      end
      redirect_to user_posts_path(@user)
    else
      flash[:alert] = "Invalid email or password"
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
