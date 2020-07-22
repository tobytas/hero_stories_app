class Search < ApplicationRecord

  extend Textacular

  belongs_to :searchable, polymorphic: true

  def results(query)
    if query
      self.class.search(query).preload(:searchable).map(&:searchable)
    else
      Search.none
    end
  end
end
