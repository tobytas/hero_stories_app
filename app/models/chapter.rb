class Chapter < ApplicationRecord

  attr_accessor :out

  has_many      :comments, dependent: :destroy
  belongs_to    :story

  validates     :content, presence: true
end
