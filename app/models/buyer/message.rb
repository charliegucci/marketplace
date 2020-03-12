class Buyer::Message < ApplicationRecord
  belongs_to :listing
# does validation to buyer_email, name and body
  validates :buyer_email, presence: true
  validates :buyer_name, presence: true
  validates :body, presence: true

  # method to send email straight away
  def send!
    UserMailer.with(message_id: self.id).contact_seller_email.deliver_now
  end

  # listing of breed
  def listing_breed
    listing.breed
  end

  # defines email of the seller
  def seller_email
    listing.user.email
  end

  # defines the picture attached to the listing
  def listing_picture
    if listing.picture.attached?
      listing.picture
    else
      "https://bulma.io/images/placeholders/256x256.png" 
    end
  end
end
