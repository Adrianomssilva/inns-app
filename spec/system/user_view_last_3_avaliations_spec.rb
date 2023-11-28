require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers


describe "Visitante/usuário vê as avaliações da pousada" do

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
      room2 = Room.create!(name: 'quarto oceano', description: 'quarto com vista mar', dimension: '20',
                          capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                          air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                          pcd: 'não', inn: inn, status:0 )
      user = User.create!(name: 'Adriano', cpf: '00000000000', email: 'adriano@email.com', password: 'password')
      reserva = Reservation.create!(room: room, user: user, start_date: 2.days.from_now,
                                    end_date: 5.days.from_now, guest_number: 2, status: 3)

      user2 = User.create!(name: 'João', cpf: '00000000000', email: 'joão@email.com', password: 'password')
      reserva2 = Reservation.create!(room: room2, user: user2, start_date: 2.days.from_now,
                                    end_date: 5.days.from_now, guest_number: 2, status: 3)

      user3 = User.create!(name: 'Pedro', cpf: '00000000000', email: 'pedro@email.com', password: 'password')
      reserva3 = Reservation.create!(room: room, user: user, start_date: 10.days.from_now,
                                    end_date: 15.days.from_now, guest_number: 2, status: 3)

      user4 = User.create!(name: 'Mateus', cpf: '00000000000', email: 'mateus@email.com', password: 'password')
      reserva4 = Reservation.create!(room: room2, user: user, start_date: 10.days.from_now,
                                    end_date: 15.days.from_now, guest_number: 2, status: 3)

      avaliacao = Avaliation.create!(user: user, inn: inn, reservation: reserva, rate: 2, text: 'Otima pousada
                                    me diverti com toda a família' )
      avaliacao2 = Avaliation.create!(user: user2, inn: inn, reservation: reserva2, rate: 3, text: 'Voltarei mais vezes' )
      avaliacao3 = Avaliation.create!(user: user3, inn: inn, reservation: reserva3, rate: 5, text: 'Equipe super preparada
                                      fez eu me sentir em casa' )
      avaliacao4 = Avaliation.create!(user: user4, inn: inn, reservation: reserva4, rate: 4, text: 'Muito bom para
                                      passar os dias com a família' )

      # Act
      travel_to(17.days.from_now) do
          visit inn_path(inn.id)
      # Assert

        expect(page).to have_content 'Nota: 3'
        expect(page).to have_content 'Voltarei mais vezes'
        expect(page).to have_content 'Nota: 5'
        expect(page).to have_content 'Equipe super preparada fez eu me sentir em casa'
        expect(page).to have_content 'Nota: 4'
        expect(page).to have_content 'Muito bom para passar os dias com a família'
        expect(page).not_to have_content 'Nota: 2'
        expect(page).not_to have_content 'Otima pousada me diverti com toda a família'
      end
    end

  end
