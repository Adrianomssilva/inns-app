class Avaliation < ApplicationRecord
  belongs_to :reservation
  belongs_to :inn
  belongs_to :user
  has_one :answer
end
