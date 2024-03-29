require 'rails_helper'

describe "Um usuário cria sua reserva" do
  it "com sucesso" do
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
                        pcd: 'não', inn: inn,status:0 )
    user = User.create!(name: 'Adriano', cpf: '00000000000', email: 'adriano@email.com', password: 'password')
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
    #Act
    login_as user, scope: :user
    visit new_room_reservation_path(room.id)
    fill_in "Data de entrada",	with: '10/11/2025'
    fill_in "Data de saída",	with: '17/11/2025'
    fill_in "Hóspedes",	with: 2
    click_on 'Verificar Reserva'
    click_on 'Confirmar Reserva'

    #Assert
    expect(page).to have_content 'Sua reserva foi confirmada'
    expect(page).to have_content 'Reserva: ABC12345'
    expect(page).to have_content 'Data de entrada: 2025-11-10'

  end

end
