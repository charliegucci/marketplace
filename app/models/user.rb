class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :listings

  has_one_attached :breeder_id_picture

  # Read: https://guides.rubyonrails.org/active_record_validations.html
  # validates :application_status valid values ['not_applied', 'applied', 'approved', 'rejected', 'completed']

  def guest?
    role == "guest"
  end

  def seller?
    role == "seller"
  end
end
