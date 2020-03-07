class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings

  has_one_attached :breeder_id_picture

  has_one_attached :avatar

  ROLE = %w(guest seller admin)
  validates :role, inclusion: {
    in: ROLE,
    message: "%{value} is not a valid role"
  }

  # Each user can 'Apply as Seller'
  # By default, a user has `not_applied`
  #
  # When the user submits his application to MansPalHouse,
  # his application_status is considered `pending`
  #
  # MansPalHouse goes through a manual process and identifies whether
  # a user has been `approved` or `rejected` to be a seller
  #
  # Once a user has been approved, and has paid his membership fee,
  # his application_status is considered `completed`
  
  APPLICATION_STATUS = %w(not_applied pending approved rejected completed)
  validates :application_status, inclusion: {
    in: APPLICATION_STATUS,
    message: "%{value} is not a valid application status"
  }

  def approved?
    application_status == 'approved'
  end

  def rejected?
    application_status == 'rejected'
  end

  def completed?
    application_status == 'completed'
  end
  
  after_save :after_approve_steps, if: Proc.new { |user| !user.seller? && user.approved? }
  after_save :after_reject_steps, if: Proc.new { |user| user.guest? && user.rejected? }
  after_save :after_complete_steps, if: Proc.new { |user| user.seller? && user.completed? }

  def after_approve_steps
    ensure_seller_role
    send_approval_email
  end

  def after_reject_steps
    send_rejection_email
  end

  def after_complete_steps
    send_confirm_payment_email
  end

  def send_confirm_payment_email
    UserMailer.with(user: self).send_confirm_payment_email.deliver_now
  end

  def send_approval_email
    UserMailer.with(user: self).seller_approval_email.deliver_now
  end

  def ensure_seller_role
    update_attributes(role: 'seller')
  end
  
  def send_rejection_email
    UserMailer.with(user: self).seller_rejection_email.deliver_now
  end

  def contact_seller_email(listing_id)
    listing = Listing.find(listing_id)
    recipient = listing.user
    breed = listing.breed
    UserMailer.with(user: self, listing: listing, recipient: recipient, breed: breed).contact_seller_email.deliver_now
    
  end

  def guest?
    role == 'guest'
  end

  def seller?
    (role == 'seller') || admin?
  end

  def admin?
    role == 'admin'
  end
end

