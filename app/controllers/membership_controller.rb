class MembershipController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:webhook]
  def new
    @user = current_user
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name:"Payee: #{@user.name}",
        description:'MansPalHouse Membership Payment',
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

  def webhook
    payment_id= params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)
    user_id = payment.metadata.user_id
    user = User.find(user_id)
    user.update_attributes(stripe_payment_id: payment_id)
    user.application_status = 'completed'
    user.save
  end

  def index
  end

  def complete
  end
end
