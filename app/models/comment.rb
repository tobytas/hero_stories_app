class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :chapter

  validates :body, presence:   true, length: { maximum: 130 }
  validates :user, uniqueness: { scope: :chapter }
end
