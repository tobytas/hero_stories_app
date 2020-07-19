class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # if params[:image_id].present?
    #   preloaded = Cloudinary::PreloadedFile.new(params[:image_id])
    #   @user.image_id = preloaded.identifier
    # end
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Hero Stories App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_id)
    end
end
