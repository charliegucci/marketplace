class Listing < ApplicationRecord
  belongs_to :breed
  belongs_to :user
  has_one_attached :picture
  has_many :buyer_messages, class_name: "Buyer::Message"

  def breeder_name
    user.name
  end

  def breeder_email
    user.email
  end

  def self.search(search_params) 
    return Listing.all if search_params.blank?
    Listing.joins(:breed).where("LOWER(breeds.name) LIKE LOWER(?)", "%#{search_params}%")
  end

end
