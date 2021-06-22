class Book < ApplicationRecord
  extend FriendlyId
  has_many :rent
  validates :gender, :author, :image, :title, :editor, :year, presence: true
  validates :year, numericality: { only_integer: true }
  validates :image, format: { with: /.*\.(jpeg|jpg|gif|png)/ }
  Reducer = Rack::Reducer.new(
    Book.all,
    ->(author:) { where('lower(author) like ?', "%#{author.downcase}%") },
    ->(gender:) { where('lower(gender) like ?', "%#{gender.downcase}%") },
    ->(title:) { where('lower(title) like ?', "%#{title.downcase}%") }
  )
  friendly_id :title, use: :slugged
end
