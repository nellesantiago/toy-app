class Post < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :description
  validates :title, length: { maximum: 20 }
end
