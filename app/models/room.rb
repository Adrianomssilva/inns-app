class Room < ApplicationRecord
  belongs_to :inn
  has_many :prices
  has_many :reservations
  validates :name, :description, :capacity, :default_price,
            :bathroom, :balcony, :air_conditioning, :tv, :wardrobe,
            :safe, :pcd, :dimension, presence: true

  enum status: {available: 0, unavailable: 2 }
end
