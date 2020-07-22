class StaticPagesController < ApplicationController

  def home
    if params[:query].present?
      @search = true
      @stories_bundle = Search.new.results(params[:query]).map do |e|
        e.class == Story ? Chapter.where(story_id: e.id).take : e
      end
      @stories_bundle.uniq!
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
