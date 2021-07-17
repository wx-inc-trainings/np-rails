class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :user_id, :book_id, :rent_start, :rent_end, presence: true
  # Validate that the starting date is equal to or greater than the current date
  validates_date :rent_start, on_or_after: -> { Date.current }
  # Validate that the end date is greater than the start date
  validates_date :rent_end, after: -> { :rent_start }

  scope :rents_order_by_end_date, lambda { |date|
    where('rent_start <= ?', date)
      .where('rent_end >= ?', date)
      .where(returned_at: nil)
      .order(rent_end: :asc)
  }

  scope :rent_end, -> { where(rent_end: Date.current).where(returned_at: nil) }
end
