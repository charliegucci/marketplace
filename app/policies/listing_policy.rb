class ListingPolicy < ApplicationPolicy
  def index?
    user.seller? && user.completed? 
  end

  def show?
    record.user == user
  end

  def create?
    user.seller? && user.completed?
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end

