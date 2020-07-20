module SessionsHelper

  # Logs in current user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged in user (if exists)
  def current_user
    # The first version with User.find_by generates a warning in RubyMine IDE
    # @current_user ||= User.find_by(id: session[:user_id])
    @current_user ||= User.where(id: session[:user_id]).take
  end

  # Confirms the correct user
  def current_user?(user)
    user == current_user
  end

  # Returns true if the user is logged in, otherwise false
  def logged_in?
    !current_user.nil?
  end

  # Logs out current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
