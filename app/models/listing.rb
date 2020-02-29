class Listing < ApplicationRecord
  belongs_to :breed
  belongs_to :user
  has_one_attached :picture

  def self.search(search)
    if search 
      return [] if search == "" || search == " "
      breeds = Breed.where("LOWER(breeds.name) LIKE LOWER(?)", "%#{search}%")
      listings = []
      breeds.each do |breed| 
           breed.listings.each do |listing|
              listings.push(listing) if breed.listings.length > 0
            end
      end
        return listings if breeds
    end  
  end
end
