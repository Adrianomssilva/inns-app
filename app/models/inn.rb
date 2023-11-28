class Inn < ApplicationRecord
  belongs_to :owner
  has_many :rooms
  validates :owner , uniqueness: true
  validates :brand_name, :corporate_name, :registration_number, :phone,
            :email, :address, :neighborhood, :city, :state, :description,
            :pets, :payment_options, :policies, :cep, :check_in, :check_out,
            presence: true
  has_many :avaliations
  enum status: {hidden: 0, published: 2}

  def full_address
    "#{address}, #{neighborhood}, #{city}, #{state}"
  end


  def self.rating(inn)
    avaliations = inn.avaliations
    notas = []

    avaliations.each do |avaliation|
      notas << avaliation.rate.to_f
    end
    tamanho = notas.count
    notas.sum./ tamanho
  end
end
