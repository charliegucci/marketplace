class Seller::RegistrationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def create
    @user = current_user
    @user.update_attributes(user_params.merge(application_status: 'pending'))

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

  def show
    @user = current_user
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :breeder_supply_number, :breeder_id_picture)
  end
end
