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
    p params
    @user = params[:user]
    @recipient = params[:recipient]
    @listing = params[:listing]
    @breed = params[:breed]
    mail(to: @user.email, subject: "[ENQUIRY] #{@listing.breeder_prefix} - #{@breed.name}")
  end
end
