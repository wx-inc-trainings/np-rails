class Book < ApplicationRecord
  validates :gender, :author, :image, :title, :editor, :year, presence: true
  validates :year, numericality: { only_integer: true }
  validates :image, format: { with: /.*\.(jpeg|jpg|gif|png)/ }
end
