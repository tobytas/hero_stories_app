class ApplicationController < ActionController::Base

  # Helpers are commonly used by views.
  # To use the helper functionality in the controller, we must include helper module.
  # Since this controller is basic for the rest, they will inherit its functionality.
  include SessionsHelper

  # Prefilters

  # Confirms user login
  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Please log in'
      redirect_to signin_path
    end
  end
end
