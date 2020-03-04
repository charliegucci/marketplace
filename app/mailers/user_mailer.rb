class UserMailer < ApplicationMailer
  def seller_approval_email
    @user = params[:user]
    mail(to: @user.email, subject: '[APPROVED] You can now sell in MansPalHouse')
  end

  # def seller_denial_email
  #   @user = params[:user]
  #   mail(to: @user.email, subject: '[NEED ] You can now sell in MansPalHouse')
  # end
end
