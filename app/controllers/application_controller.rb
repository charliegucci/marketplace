class ApplicationController < ActionController::Base
  include Pundit

  default_form_builder BulmaFormBuilder
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: :public_controller?

  protected

  def public_controller?
    devise_controller? || whitelisted_controllers.include?(self.class)
  end

  def whitelisted_controllers
    [HomeController]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :street_number_name, :suburb, :state])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :street_number_name, :suburb,
       :postcode, :breeder_supply_number, :state])
  end
end

