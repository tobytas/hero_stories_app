module ApplicationHelper

  # Returns title based on the page title
  def full_title(page_title = '')
    base_title = 'Hero Stories App'

    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
