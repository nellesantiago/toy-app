class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      login(@user)
      if @user.admin?
        redirect_to admin_dashboard_path
        return
      end
      redirect_to user_posts_path(@user)
    else
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
