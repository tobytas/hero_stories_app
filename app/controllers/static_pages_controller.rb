class StaticPagesController < ApplicationController

  def home
    if params[:query].present?
      @search = true
      @stories_bundle = Chapter.search_everywhere(params[:query])
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
