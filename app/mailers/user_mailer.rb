class UserMailer < ApplicationMailer
  def seller_approval_email
    @user = params[:user]
    mail(to: @user.email, subject: '[APPROVED] You can now sell in MansPalHouse')
  end

  def seller_rejection_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Your MansPalHouse application has been rejected')
  end
end
