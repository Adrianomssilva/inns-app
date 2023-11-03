class Inn < ApplicationRecord
  belongs_to :owner
  validates :owner , uniqueness: true

  enum status: {hidden: 0, published: 2}

  def full_address
    "#{address}, #{neighborhood}, #{city}, #{state}"
  end
end
