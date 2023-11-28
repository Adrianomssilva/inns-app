require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe 'Owner acessa todas as avaliações' do
  it "e as vê" do
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
    reserva2 = Reservation.create!(room: room2, user: user, start_date: 10.days.from_now,
                                  end_date: 15.days.from_now, guest_number: 2, status: 3)
    avaliacao = Avaliation.create!(user: user, inn: inn, reservation: reserva, rate: 4, text: 'Otima pousada
                                  me diverti com toda a família' )
    avaliacao2 = Avaliation.create!(user: user, inn: inn, reservation: reserva2, rate: 5, text: 'Otima pousada.
                                  Quarto incrível.' )

    # Act
    travel_to(17.days.from_now) do
        login_as owner, scope: :owner
        visit root_path
        click_on "Avaliações"

    # Assert

      expect(page).to have_content 'Quarto: quarto do beco'
      expect(page).to have_content 'Nota: 4'
      expect(page).to have_content 'Otima pousada me diverti com toda a família'
      expect(page).to have_content 'Quarto: quarto oceano'
      expect(page).to have_content 'Nota: 5'
      expect(page).to have_content 'Otima pousada. Quarto incrível.'

    end
  end

  it "e responde uma avaliação" do
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

    # Act
    travel_to(17.days.from_now) do
        login_as owner, scope: :owner
        visit root_path
        click_on "Avaliações"
        click_on "Responder"
        fill_in 'Resposta', with: "Foi otimo sua estadia aqui. Esperamos o retorno"
        click_on 'Enviar'

    # Assert

      expect(page).to have_content 'Quarto: quarto do beco'
      expect(page).to have_content 'Nota: 4'
      expect(page).to have_content 'Otima pousada me diverti com toda a família'
      expect(page).to have_content 'Resposta: Foi otimo sua estadia aqui. Esperamos o retorno'

    end
  end
end
