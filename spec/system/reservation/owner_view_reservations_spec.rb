require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe "Dono da pousada as reservas" do
  it "dono acessa o menu de reservas da pousada" do
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
                        pcd: 'não', inn: inn, status:0 )
    room2 = Room.create!(name: 'quarto oceano', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn, status:0 )
    user = User.create!(name: 'Adriano', cpf: '00000000000', email: 'adriano@email.com', password: 'password')
    user2 = User.create!(name: 'João', cpf: '00000000000', email: 'joão@email.com', password: 'password')
    reserva = Reservation.create!(room: room, user: user, start_date: 10.days.from_now,
                                  end_date: 15.days.from_now, guest_number: 2)
    reserva2 = Reservation.create!(room: room2, user: user, start_date: 11.days.from_now,
                                  end_date: 16.days.from_now, guest_number: 2)

    # Act
    login_as owner, scope: :owner
    visit root_path
    click_on 'Reservas'

    #Assert
    expect(page).to have_content 'quarto do beco'
    expect(page).to have_content "Cod: #{reserva.code}"
    expect(page).to have_content "Data de entrada: #{reserva.start_date}"
    expect(page).to have_content "Data de saída: #{reserva.end_date}"
    expect(page).to have_content "Número de hóspedes: 2"
    expect(page).to have_content 'quarto oceano'
    expect(page).to have_content "Cod: #{reserva2.code}"
    expect(page).to have_content "Data de entrada: #{reserva2.start_date}"
    expect(page).to have_content "Data de saída: #{reserva2.end_date}"
    expect(page).to have_content "Número de hóspedes: 2"
  end

  it "clica no botão check-in e faz check_in com sucesso " do
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
                        pcd: 'não', inn: inn, status:0 )
    room2 = Room.create!(name: 'quarto oceano', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn, status:0 )
    user = User.create!(name: 'Adriano', cpf: '00000000000', email: 'adriano@email.com', password: 'password')
    reserva = Reservation.create!(room: room, user: user, start_date: 10.days.from_now,
                                  end_date: 15.days.from_now, guest_number: 2)
    # Act
    travel_to(10.days.from_now) do
        login_as owner, scope: :owner
        visit reservations_path
        click_on 'Check-in'

    # Assert
    expect(page).not_to have_content 'quarto do beco'
    expect(page).not_to have_content "Cod: #{reserva.code}"
    expect(page).not_to have_content "Data de entrada: #{reserva.start_date}"
    expect(page).not_to have_content "Data de saída: #{reserva.end_date}"
    expect(page).not_to have_content "Número de hóspedes: 2"
    end
  end

  it "clica no botão check-in e faz check_in sem sucesso " do
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
                        pcd: 'não', inn: inn, status:0 )
    room2 = Room.create!(name: 'quarto oceano', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn, status:0 )
    user = User.create!(name: 'Adriano', cpf: '00000000000', email: 'adriano@email.com', password: 'password')
    reserva = Reservation.create!(room: room, user: user, start_date: 10.days.from_now,
                                  end_date: 15.days.from_now, guest_number: 2)
    # Act
    travel_to(9.days.from_now) do
        login_as owner, scope: :owner
        visit reservations_path
        click_on 'Check-in'

    # Assert
    expect(page).to have_content 'quarto do beco'
    expect(page).to have_content "Cod: #{reserva.code}"
    expect(page).to have_content "Data de entrada: #{reserva.start_date}"
    expect(page).to have_content "Data de saída: #{reserva.end_date}"
    expect(page).to have_content "Número de hóspedes: 2"
    expect(page).to have_content "O Check-in só pode ser feito no dia ou depois da data de entrada da reserva"
    end
  end

end
