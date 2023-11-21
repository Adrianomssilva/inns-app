require 'rails_helper'

describe "Usúario sem login reserva um quarto" do

  it "escolhe o quarto e chega na página com detalhes e um formulário" do
    #Arrange
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

    #Act
      visit root_path
      click_on 'Pousada Alegre'
      click_on 'quarto do beco'

    #Assert
    expect(page).to have_content 'quarto do beco'
    expect(page).to have_content 'Descrição: quarto com vista mar'
    expect(page).to have_content 'Capacidade: 2'
    expect(page).to have_field   'Data de entrada'
    expect(page).to have_field   'Data de saída'
    expect(page).to have_field   'Hóspedes'
    expect(page).to have_button   'Verificar Reserva'

  end

  it "consulta a reserva e chega na página de login" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 2 )
    room = Room.create!(name: 'quarto do beco', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '500', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn,status:0 )

    # Act

    visit new_room_reservation_path(room.id)
    fill_in "Data de entrada",	with: '10/11/2025'
    fill_in "Data de saída",	with: '17/11/2025'
    fill_in "Hóspedes",	with: 2
    click_on 'Verificar Reserva'

    # Assert
      expect(current_path).to eq new_user_session_path

  end

  it "consulta a reserva e da errado" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 2 )
    room = Room.create!(name: 'quarto do beco', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '500', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn,status:0 )

    # Act
    visit new_room_reservation_path(room.id)
    fill_in "Data de entrada",	with: ''
    fill_in "Data de saída",	with: ''
    fill_in "Hóspedes",	with: 2
    click_on 'Verificar Reserva'

    # Assert
      expect(page).to have_content 'Verifique os erros abaixo'

  end

  it "consulta a reserva e chega na página de confirmação" do
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

    # Act
    visit new_room_reservation_path(room.id)
    fill_in "Data de entrada",	with: '10/11/2025'
    fill_in "Data de saída",	with: '17/11/2025'
    fill_in "Hóspedes",	with: 2
    click_on 'Verificar Reserva'
    fill_in "Email",	with: "adriano@email.com"
    fill_in "Password", with: "password"
    within("div.actions") do
    click_on 'Entrar'
    end

    # Assert
      expect(page).to have_content 'Resumo da reserva'
      expect(page).to have_content  "Data de entrada: 2025-11-10"
      expect(page).to have_content  "Data de saída: 2025-11-17"
      expect(page).to have_content  "quarto do beco"
      expect(page).to have_content  "Total: 1050"
      expect(page).to have_content  "Check-in: 13:00"
      expect(page).to have_content  "Check-out: 12:00"
      expect(page).to have_content  "Formas de pagamento: Cartão"

  end

  it "consulta a reserva, o quarto tem preço variável" do
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
    price = Price.create!(date_start: '2025-11-15', date_end: '2025-11-17', value: 200, room_id: room.id)
    user = User.create!(name: 'Adriano', cpf: '00000000000', email: 'adriano@email.com', password: 'password')

    # Act
    login_as user, scope: :user
    visit new_room_reservation_path(room.id)
    fill_in "Data de entrada",	with: '10/11/2025'
    fill_in "Data de saída",	with: '17/11/2025'
    fill_in "Hóspedes",	with: 2
    click_on 'Verificar Reserva'

    # Assert
      expect(page).to have_content 'Resumo da reserva'
      expect(page).to have_content  "Data de entrada: 2025-11-10"
      expect(page).to have_content  "Data de saída: 2025-11-17"
      expect(page).to have_content  "quarto do beco"
      expect(page).to have_content  "Total: 1150"
      expect(page).to have_content  "Check-in: 13:00"
      expect(page).to have_content  "Check-out: 12:00"
      expect(page).to have_content  "Formas de pagamento: Cartão"

  end



end
