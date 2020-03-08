class UserMailer < ApplicationMailer
  def seller_approval_email
    @user = params[:user]
    mail(to: @user.email, subject: '[APPROVED] You can now sell in MansPalHouse')
  end

  def seller_rejection_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Your MansPalHouse application has been rejected')
  end

  def contact_seller_email
    @message = Buyer::Message.find(params[:message_id])
    @listing = @message.listing
    @breed = @message.listing_breed
    @body = @message.body
    mail(from: @message.buyer_email, to: @listing.user.email, subject: "[ENQUIRY] #{@listing.breeder_prefix} - #{@breed.name}")
  end

  def send_confirm_payment_email
    @user = params[:user]
    mail(to: @user.email, subject: '[SUCCESSFUL] Your Payment was approved')
  end
end
