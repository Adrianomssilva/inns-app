class Room < ApplicationRecord
  belongs_to :inn

  enum status: {available: 0, unavailable: 2 }
end
