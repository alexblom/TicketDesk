class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :user_name_by_id
  before_filter :require_login
  
  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def require_login
      unless current_user
        redirect_to log_in_path, notice: 'Must be logged in'
      end
    end
    
    def user_name_by_id(id)
      user = User.find_by_id(id)
      @name = user.name
    end
  
end
