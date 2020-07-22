class Chapter < ApplicationRecord

  has_many   :comments
  belongs_to :story
end
