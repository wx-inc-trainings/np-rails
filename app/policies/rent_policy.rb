class RentPolicy < ApplicationPolicy
  def index?
    user.id == record.first.user_id
  end

  def create?
    user.present? && record.user.id == user.id
  end

  def book_ranking?
    user.present?
  end

  def active?
    user.present?
  end
end
