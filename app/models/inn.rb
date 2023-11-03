class Inn < ApplicationRecord
  belongs_to :owner
  validates :owner , uniqueness: true
end
