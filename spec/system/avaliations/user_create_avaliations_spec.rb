require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Usuário cria uma avaliação da pousada' do
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
    travel_to(17.days.from_now) do
        login_as user, scope: :user
        visit reservation_path(reserva.id)
        click_on "Fazer uma avaliação"
        fill_in "Avaliação", with: "Pousada muito boa, ótimo atendimento. Incrível estadia."
        select '4', from: 'Nota'
        click_on 'Avaliar'

    # Assert
      expect(current_path).to eq reservation_path(reserva.id)
      expect(page).to have_content 'Nota: 4'
      expect(page).to have_content 'Pousada muito boa, ótimo atendimento. Incrível estadia.'

    end
  end

  it "Usuário vê a resposta da pousada" do
    # Arrange
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
    user = User.create!(name: 'Adriano', cpf: '00000000000', email: 'adriano@email.com', password: 'password')
    reserva = Reservation.create!(room: room, user: user, start_date: 10.days.from_now,
                                  end_date: 15.days.from_now, guest_number: 2, status: 3)
    avaliacao = Avaliation.create!(user: user, inn: inn, reservation: reserva, rate: 4, text: 'Otima pousada
                                  me diverti com toda a família' )
    check_in = CheckIn.create!(entry: 10.days.from_now, reservation: reserva)
    check_out = CheckOut.create!(exit: 15.days.from_now, reservation: reserva, total: 600)
    resposta = Answer.create!(text: 'Esperamos seu retorno', avaliation: avaliacao)


    # Act
    travel_to(17.days.from_now) do
        login_as user, scope: :user
        visit reservation_path(reserva.id)

    # Assert
      expect(current_path).to eq reservation_path(reserva.id)
      expect(page).to have_content 'Pousada Alegre: Esperamos seu retorno'

    end
  end
end
