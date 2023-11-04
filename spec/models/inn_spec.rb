require 'rails_helper'

RSpec.describe Inn, type: :model do
  describe "text owner em pousada" do
    it "passar pousada sem dono" do
      # Arrange
    inn = Inn.new(brand_name: 'teste')
    # Act
    result = inn.valid?
    # Assert
    expect(result).to eq false
    end

    it "cada dono só pode ter uma pousada" do
      # Arrange
      owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')

      inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                        status: 0 )
      inn2 = Inn.new(brand_name: 'Pousada feliz', corporate_name: 'Pousada feliz ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                        status: 0 )
      # Act
      result = inn2.valid?

      # Arrange
      expect(result).to eq false

    end



  end

end
