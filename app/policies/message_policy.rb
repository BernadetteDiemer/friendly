class MessagePolicy < ApplicationPolicy
  def create?
    users = record.chatroom.event.bookings.map(&:user)
    users.include?(user) || record.chatroom.event.user == user
  end
end
