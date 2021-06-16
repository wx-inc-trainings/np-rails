class BookSuggestion < ApplicationRecord
  belongs_to :user
  validates :author, :title, :link, :editor, :year, :user_id, presence: true
end
