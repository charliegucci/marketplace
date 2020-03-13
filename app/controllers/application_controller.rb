class ApplicationController < ActionController::Base
  include Pundit #authorization gem
  include Pagy::Backend #pagination gem
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # bulma css form builder
  default_form_builder BulmaFormBuilder 
  
  # callback action to check configure_permitted_parameters for devise controller and permits
  before_action :configure_permitted_parameters, if: :devise_controller? 

  # devise helper to check authorization unless define in public controller
  after_action :verify_authorized, unless: :public_controller?

  protected

  # devise method to route user to particular path 
  def after_sign_in_path_for(resource)
    if current_user.seller? && current_user.approved?
        membership_path
    elsif current_user.seller? && current_user.completed?
        home_path
    else 
      root_path
    end    
  end

  # defines public controller
  def public_controller?
    devise_controller? || whitelisted_controllers.include?(self.class)
  end

  # list of controllers who doesnt need  authentication
  def whitelisted_controllers
    [
      HomeController,
      Seller::RegistrationsController,
      MembershipController,
      Buyer::MessagesController,
    ]
  end

  # allows params to be pass
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :street_number_name, :suburb, :state, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :street_number_name, :suburb,
      :postcode, :breeder_supply_number, :state, :avatar])
  end
  
  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end

