class MembershipController < ApplicationController
  before_action :authenticate_user!
  def new
    @user = current_user
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @user.name,
        description:'Membership Payment',
        amount: 5000,
        currency:'aud',
        quantity: 1,
      }],
      payment_intent_data: {
        metadata: {
          user_id: @user.id
        }
      },
      success_url: "#{root_url}membership/complete",
   cancel_url: "#{root_url}",
   )
 end
  def index
  end

  def complete
  end

end
