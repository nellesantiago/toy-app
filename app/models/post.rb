class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates_presence_of :title, :description
  validates :title, length: { maximum: 20 }
end
