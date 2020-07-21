class StaticPagesController < ApplicationController

  def home
    @search_results = Chapter.search_everywhere(params[:query])
  end

  def help
  end

  def about
  end

  def contact
  end
end
