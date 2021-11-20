class ChatroomPolicy < ApplicationPolicy
  def show?
    users = record.event.bookings.map(&:user)
    users.include?(user) || record.event.user == user
  end
end
