class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    record == user
  end

  def show?
    user.present?
  end

  def update?
    record == user
  end
end
