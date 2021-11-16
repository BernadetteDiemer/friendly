class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record == user #|| record.user == show
  end

  def update?
    record == user
  end
end
