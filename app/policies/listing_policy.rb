class ListingPolicy < ApplicationPolicy
  def index?
    user.seller?
  end

  def show?
    record.user == user
  end

  def create?
    user.seller?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
