# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def seller_approval_email
    UserMailer.with(user: User.last).seller_approval_email.deliver_now
  end

  def seller_rejection_email
    UserMailer.with(user: User.last).seller_rejection_email.deliver_now
  end

  def contact_seller_email
    @message = Buyer::Message.last
    UserMailer.with(message_id: @message.id).contact_seller_email.deliver_now
  end
end

