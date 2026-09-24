class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  private
  # returns the currently logged-in user based on the session's user_id
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # checks if a user is logged in by verifying if current_user is present
  def logged_in?
    current_user.present?
  end

  # requires the user to be logged in 
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in first."
    end
  end

  # logs in the given user by setting the session's user_id to the user's id
  def log_in(user)
    session[:user_id] = user.id
  end

  # logs out the current user by resetting the session
  def log_out
    reset_session
  end
end