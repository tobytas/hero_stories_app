class ChaptersController < ApplicationController

  def new
    unless session[:story_id]
      flash[:success] = 'Story successfully saved'
      redirect_to user_path(current_user)
    end
    @chapter = Chapter.new
  end

  def create
    @chapter = Story.find_by(id: session[:story_id]).chapters.build(chapter_params)
    @chapter.number = session[:chapt_num] == 0 ? 1 : session[:chapt_num] + 1

    if @chapter.save
      session[:chapt_num] = @chapter.number
      if @chapter.out.to_i != 0
        session.delete(:story_id)
        session.delete(:chapt_num)
      end
        redirect_to new_chapter_path
    else
        render 'new'
    end
  end

  private
    def chapter_params
      params.require(:chapter).permit(:content, :out)
    end
end
