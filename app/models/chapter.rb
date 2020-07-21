class Chapter < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_everywhere,
                  against: [:content],
                  using:   { tsearch: { dictionary: 'english',
                                        tsvector_column: 'tsv' } }

  has_many   :comments
  belongs_to :story
end
