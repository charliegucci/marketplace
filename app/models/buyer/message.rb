class Buyer::Message < ApplicationRecord
  belongs_to :listing

  validates :buyer_email, presence: true
  validates :buyer_name, presence: true
  validates :body, presence: true

  def send!
    UserMailer.with(message_id: self.id).contact_seller_email.deliver_now
  end

  def listing_breed
    listing.breed
  end

  def seller_email
    listing.user.email
  end

  def listing_picture
    if listing.picture.attached?
      listing.picture
    else
      "https://bulma.io/images/placeholders/256x256.png"
    end
  end
end
