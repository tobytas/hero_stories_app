class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :chapter

  validates :user, uniqueness: { scope: :chapter }
end
