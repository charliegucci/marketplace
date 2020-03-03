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

  after_save :ensure_seller_role, if: Proc.new { |user| !user.seller? && user.approved? }

  def approved?
    application_status == 'approved'
  end

  def ensure_seller_role
    update_attributes(role: 'seller')
  end

  def guest?
    role == 'guest'
  end

  def seller?
    role == 'seller'
  end

  def admin?
    role == 'admin'
  end
end
