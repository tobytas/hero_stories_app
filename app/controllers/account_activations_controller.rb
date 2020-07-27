class AccountActivationsController < ApplicationController

  def edit
    user = User.where(email: params[:email]).take
    byebug
    if user && !user.activated? && user.authenticated?(params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)

      log_in user

      flash[:success] = 'Account activated!'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_path
    end
  end
end
