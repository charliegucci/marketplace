class Listing < ApplicationRecord
  belongs_to :breed
  belongs_to :user
  has_one_attached :picture
  has_many :buyer_messages, class_name: "Buyer::Message"

  # defines the sellers name
  def breeder_name
    user.name
  end

  # defines the sellers email
  def breeder_email
    user.email
  end

  # search query for the search bar
  def self.search(search_params) 
    return Listing.all if search_params.blank?
    Listing.joins(:breed).where("LOWER(breeds.name) LIKE LOWER(?)", "%#{search_params}%")
  end

end
