class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings

  has_one_attached :breeder_id_picture

  validates :role, inclusion: {
    in: %w(guest seller admin),
    message: "%{value} is not a valid role"
  }

  validates :application_status, inclusion: {
    in: %w(not_applied applied approved rejected completed),
    message: "%{value} is not a valid application status"
  }

  def guest?
    role == "guest"
  end

  def seller?
    role == "seller"
  end
end
