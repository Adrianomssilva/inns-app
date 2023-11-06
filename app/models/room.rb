class Room < ApplicationRecord
  belongs_to :inn
  has_many :prices

  enum status: {available: 0, unavailable: 2 }
end
