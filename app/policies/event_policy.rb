class EventPolicy < ApplicationPolicy
  def new?
    return true
  end

  def create?
    return true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
