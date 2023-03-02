class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates_presence_of :title, :description
  validates :title, length: { maximum: 20 }
end
