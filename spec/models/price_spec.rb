require 'rails_helper'

RSpec.describe Price, type: :model do

  describe "a data do preço não pode sobrepor outra data" do
    it "deve ocorrer um erro" do
      # Arrange
      owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
      inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 2 )
      room = Room.create!(name: 'quarto do beco', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn,status:2 )
      price1 = Price.create!(value: '200', date_start: '2023-11-20', date_end: '2023-11-30', room_id: room.id)
      price2 = Price.new(value: '200', date_start: '2023-11-20', date_end: '2023-12-20', room_id: room.id)

      # Act
      result = price2.valid?
      # Arrange
      expect(result).to eq false
    end

    it "Quartos diferentes o erro não deve acontecer!" do
      # Arrange
      owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
      inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 2 )
      room = Room.create!(name: 'quarto do beco', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn,status:2 )
      room1 = Room.create!(name: 'quarto azul', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn,status:2 )
      price1 = Price.create!(value: '200', date_start: '2023-11-20', date_end: '2023-11-30', room_id: room.id)
      price2 = Price.new(value: '200', date_start: '2023-11-20', date_end: '2023-12-20', room_id: room1.id)

      # Act
      result = price2.valid?
      # Arrange
      expect(result).to eq true
    end


  end

end
