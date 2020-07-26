class Story < ApplicationRecord

  has_many   :chapters,    dependent: :destroy
  belongs_to :user

  validates  :title,       presence: true
  validates  :genre,       presence: true
  validates  :description, presence: true
end
