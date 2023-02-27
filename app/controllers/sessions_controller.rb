class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
    login(@user)
    redirect_to posts_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end


