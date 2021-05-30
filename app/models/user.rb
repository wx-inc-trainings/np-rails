# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :confirmable, :validatable
  include DeviseTokenAuth::Concerns::User

  # set first_name and last_name required
  validates :first_name, :last_name, presence: true
end
