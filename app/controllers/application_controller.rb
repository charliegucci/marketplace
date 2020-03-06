class ApplicationController < ActionController::Base
  include Pundit

  default_form_builder BulmaFormBuilder
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: :public_controller?

  protected

  def after_sign_in_path_for(resource)
    if current_user.seller? && current_user.approved?
        membership_path
    elsif current_user.seller? && current_user.completed?
        listings_path
    else 
      root_path
    end    
  end

  def public_controller?
    devise_controller? || whitelisted_controllers.include?(self.class)
  end

  def whitelisted_controllers
    [
      HomeController,
      Seller::RegistrationsController, MembershipController
    ]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :street_number_name, :suburb, :state, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :street_number_name, :suburb,
      :postcode, :breeder_supply_number, :state, :avatar])
  end
end

