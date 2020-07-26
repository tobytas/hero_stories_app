class StoriesController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @story = Story.new
  end

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      flash[:success] = 'Title successfully created'

      session[:story_id] = @story.id
      session[:chapt_num] = 0
      redirect_to new_chapter_path
    else
      render 'new'
    end
  end

  def show
    @story = Story.find(params[:id])
    @chapters = @story.chapters.paginate(per_page: 1, page: params[:page])
  end

  def destroy
    @story.destroy
    flash[:success] = "Story deleted"
    # Go to previous url
    redirect_to request.referer
  end

  private
    def story_params
      params.require(:story).permit(:title, :genre, :description)
    end

    # Prefilters

    # Check for history with given id
    def correct_user
      @story = current_user.stories.find_by(id: params[:id])
      redirect_to root_path unless @story
    end
end
