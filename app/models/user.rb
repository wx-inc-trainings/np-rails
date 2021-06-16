class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :book_suggestion
  # set first_name and last_name required
  validates :first_name, :last_name, presence: true
end
