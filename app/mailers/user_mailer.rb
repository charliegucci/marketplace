class UserMailer < ApplicationMailer
 
  # method that send approval email to user
  def seller_approval_email
    @user = params[:user]
    mail(to: @user.email, subject: '[APPROVED] You can now sell in MansPalHouse')
  end

  # method that send rejection email to user
  def seller_rejection_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Your MansPalHouse application has been rejected')
  end

  # method that creates email to send to listing user
  def contact_seller_email
    @message = Buyer::Message.find(params[:message_id])
    @listing = @message.listing
    @breed = @message.listing_breed
    @body = @message.body
    mail(from: @message.buyer_email, to: @listing.user.email, subject: "[ENQUIRY] #{@listing.breeder_prefix} - #{@breed.name}")
  end

  # method that send confirm_payment email to user
  def send_confirm_payment_email
    @user = params[:user]
    mail(to: @user.email, subject: '[SUCCESSFUL] Your Payment was approved')
  end
end
