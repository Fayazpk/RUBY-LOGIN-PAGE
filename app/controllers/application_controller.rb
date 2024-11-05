class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  
  private
  def authenticate_user!
    redirect_to login_path, alert: 'You must be logged in to access this page.' unless user_signed_in?
  end
  def require_login
    unless session[:user_id]
      redirect_to login_path, alert: "Please log in to continue"
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
  
  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end
  
  def user_signed_in?
    current_user.present?  
  end
  helper_method :user_signed_in?
  
  def login(user)
    current_user = user
    reset_session
    session[:user_id] = user.id
  end
  
  
  def logout
    @current_user = nil
    reset_session
  end
  
  def redirect_if_authenticated
    redirect_to home_main_path if user_signed_in?
  end
end
