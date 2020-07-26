module ChaptersHelper

  def chapter_number
    "Chapter #{session[:chapt_num] + 1}"
  end
end
