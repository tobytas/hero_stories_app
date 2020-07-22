class StaticPagesController < ApplicationController

  def home
    if params[:query].present?
      @search = true
      @stories_bundle = Search.new.results(params[:query]).map()

      @stories_bundle.each_with_index do |e, i|
        if e.class == Story
          @stories_bundle[i] = Chapter.where(story_id: e.id).take
        end
      end
    else
      @stories_bundle = Chapter.order(updated_at: :desc).take(3)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
