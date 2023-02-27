module SessionsHelper
    def login(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    def user_logged_in?
        !!current_user
    end

    def authenticate_user
        redirect_to root_path unless user_logged_in?
    end

    def current_user?(user)
        current_user == user
    end
end

