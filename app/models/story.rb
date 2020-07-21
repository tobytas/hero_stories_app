class Story < ApplicationRecord

  has_many   :chapters
  belongs_to :user
end
