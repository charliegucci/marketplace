class Seller::RegistrationsController < ApplicationController
  before_action :authenticate_user!
# defines @ user as current_user
  def new
    @user = current_user
  end
# defines @ user as current_user
  def edit
    @user = current_user
  end
# whenever new user was created application status changed from not applied to pending
  def create
    @user = current_user
    @user.update_attributes(user_params.merge(application_status: 'pending'))
# check if user was updated then show it when no error otherwise flash error message
    respond_to do |format|
      unless @user.errors.any?
        format.html { redirect_to action: "show", id: @user.id }
      else
        format.html do
          flash[:alert] = "Seller registration was not successful due to the following: #{@user.errors.full_messages.join(', ')}"
          render :new
        end
      end
    end
  end
# defines @ user as current_user
  def show
    @user = current_user
  end

  protected
# sanitized data being pass as params
  def user_params
    params.require(:user).permit(:name, :email, :breeder_supply_number, :breeder_id_picture)
  end
end
