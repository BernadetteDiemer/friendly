class ChatroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
      end
    end

  def show?
    users = record.event.bookings.map(&:user)
    users.include?(user) || record.event.user == user
  end
end
