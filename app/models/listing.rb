class Listing < ApplicationRecord
  belongs_to :breed
  belongs_to :user
  has_one_attached :picture
end
