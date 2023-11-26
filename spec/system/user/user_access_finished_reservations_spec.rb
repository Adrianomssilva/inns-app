require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe "Usuário vê seus reserva finalizadas" do
  it "Usuário acessa uma reserva finalizada e vê botão para avaliação" do
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
                                  end_date: 15.days.from_now, guest_number: 2, status: 3)
    check_in = CheckIn.create!(entry: 10.days.from_now, reservation: reserva)
    check_out = CheckOut.create!(exit: 15.days.from_now, reservation: reserva, total: 600)

    # Act
    travel_to(16.days.from_now) do
        login_as user, scope: :user
        visit my_reservations_path
        click_on "Acessar reserva"

    # Assert
      expect(page).to have_content "Cod: #{reserva.code}"
      expect(page).to have_content 'Quarto: quarto do beco'
      expect(page).to have_content "Check-in: #{reserva.check_in.entry}"
      expect(page).to have_content "Check-out: #{reserva.check_out.exit}"
      expect(page).to have_content "Valor Total: #{reserva.check_out.total}"
      expect(page).to have_link "Fazer uma avaliação"
    end
  end

  it "Usuário acessa uma reserva não finalizada" do
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
                                  end_date: 15.days.from_now, guest_number: 2, status: 2)
    check_in = CheckIn.create!(entry: 10.days.from_now, reservation: reserva)
    check_out = CheckOut.create!(exit: 15.days.from_now, reservation: reserva, total: 600)

    # Act
    travel_to(16.days.from_now) do
        login_as user, scope: :user
        visit reservation_path(reserva.id)


    # Assert
      expect(page).to have_content "nada"
    end


  end



end
