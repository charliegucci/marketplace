# This is a headless policy (not tied to any resource)
# used for checking if a user can access the admin dashboard
# Source: https://github.com/varvet/pundit/#headless-policies
class AdminDashboardPolicy < Struct.new(:user, :dashboard)
  def index?
    user.admin?
  end

  def show?
    user.admin?
  end

  def create?
    user.admin?
  end

  def new?
    create?
  end

  def update?
    user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    user.admin?
  end
end