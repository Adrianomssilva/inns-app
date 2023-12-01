require 'rails_helper'
include ActiveSupport::Testing::TimeHelpers

describe "Inn APi" do

  context "Get /api/v1/inss" do

    it "sucesso" do
      # Arrange
      owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
      owner2 = Owner.create!(name: 'Adriano', email:'adr@email.com', password: 'password')
      inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                        status: 2 )
      inn2 = Inn.create!(brand_name: 'Pousada feliz', corporate_name: 'Pousada feliz ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner2,
                        status: 2 )

      # Act
        get "/api/v1/inns"
      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq 2
        expect(json_response[0]["brand_name"]).to eq 'Pousada Alegre'
        expect(json_response[1]["brand_name"]).to eq 'Pousada feliz'

    end

    it "sucesso apenas com as publicadas" do
      # Arrange
      owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
      owner2 = Owner.create!(name: 'Adriano', email:'adr@email.com', password: 'password')
      inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                        status: 2 )
      inn2 = Inn.create!(brand_name: 'Pousada feliz', corporate_name: 'Pousada feliz ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner2,
                        status: 0 )

      # Act
        get "/api/v1/inns"
      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq 1
        expect(json_response[0]["brand_name"]).to eq 'Pousada Alegre'
        expect(json_response[1]).to eq nil

    end

    it "Retorna vazio" do
      # Arrange

      # Act
        get "/api/v1/inns"
      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response).to eq []
    end

    it "sem sucesso por erro do servidor" do
      # Arrange
      allow(Inn).to receive(:all).and_raise(ActiveRecord::QueryCanceled)
      # Act
        get "/api/v1/inns"
      # Assert
        expect(response).to have_http_status(500)
    end

    it "Faz pesquisa no inns" do
      # Arrange
      query = {"query":'Alegre'}
      owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
      owner2 = Owner.create!(name: 'Adriano', email:'adr@email.com', password: 'password')
      inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                        status: 2 )
      inn2 = Inn.create!(brand_name: 'Pousada feliz', corporate_name: 'Pousada feliz ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner2,
                        status: 2 )
      # Act
        post "/api/v1/inns/search", params: query
      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq 1
        expect(json_response[0]["brand_name"]).to eq 'Pousada Alegre'
        expect(json_response[1]).to eq nil
    end

    it "Faz pesquisa em branco" do
      # Arrange
      query = {"query":''}
      owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
      owner2 = Owner.create!(name: 'Adriano', email:'adr@email.com', password: 'password')
      inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                        status: 2 )
      inn2 = Inn.create!(brand_name: 'Pousada feliz', corporate_name: 'Pousada feliz ltda',
                        registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                        address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                        payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                        policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner2,
                        status: 2 )
      # Act
        post "/api/v1/inns/search", params: query
      # Assert
        expect(response).to have_http_status(400)
        expect(response.content_type).to include 'application/json'
        expect(response.body).to include 'Error'
    end


    it "Faz pesquisa no inns e da erro no servidor" do
      # Arrange
      allow(Inn).to receive(:where).and_raise(ActiveRecord::QueryCanceled)
      query = {"query":'Alegre'}
      # Act
        post "/api/v1/inns/search", params: query
      # Assert
        expect(response).to have_http_status(500)
    end


  end

  context "Get /api/v1/inn.id/rooms" do
    it 'com sucesso' do
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
      room3 = Room.create!(name: 'quarto do milhão', description: 'suíte presidencial', dimension: '40',
                        capacity: 10, default_price: '600', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'Sim', inn: inn, status: 0 )
      # Act
      get "/api/v1/inns/#{inn.id}/rooms"

      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq 2
        expect(json_response[0]["name"]).to eq 'quarto do beco'
        expect(json_response[1]["name"]).to eq 'quarto do milhão'
    end

    it 'com sucesso apenas quartos válidos' do
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
      room3 = Room.create!(name: 'quarto do milhão', description: 'suíte presidencial', dimension: '40',
                        capacity: 10, default_price: '600', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'Sim', inn: inn, status: 2 )
      # Act
      get "/api/v1/inns/#{inn.id}/rooms"

      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq 1
        expect(json_response[0]["name"]).to eq 'quarto do beco'
        expect(json_response[1]).to eq nil
    end

    it 'sem sucesso' do
      # Arrange

      # Act
      get "/api/v1/inns/99999999/rooms"

      # Assert
        expect(response).to have_http_status(404)

    end

  end

  context "Get /api/v1/inn/inn.id" do
    it 'com sucesso' do
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
      get "/api/v1/inns/#{inn.id}"

      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response["brand_name"]).to eq 'Pousada Alegre'
        expect(json_response.keys).not_to include('registration_number')
        expect(json_response.keys).not_to include('corporate_name')
        expect(json_response.keys).to include('nota')
        expect(json_response["nota"]).to eq 4.0
      end
    end

    it 'sem sucesso' do
      # Arrange

      # Act
      get "/api/v1/inns/99999999"

      # Assert
      expect(response).to have_http_status(404)
    end

  end

  describe "Post /api/v1/reservations" do

    it 'sucesso' do
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
      reservation_params = { reservation: { room_id: room.id, start_date: 10.days.from_now,
                            end_date: 15.days.from_now, guest_number: 2}}

      # Act
      post '/api/v1/reservations', params: reservation_params

      # Assert
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.keys).to include('total_value')
      expect(json_response["total_value"]).to eq 750
    end

    it 'sem sucesso por falta de dados' do
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
      reservation_params = { reservation: {start_date: 10.days.from_now,
                            end_date: 15.days.from_now, guest_number: 2}}

      # Act
      post '/api/v1/reservations', params: reservation_params

      # Assert
      expect(response).to have_http_status(412)
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Room é obrigatório(a)'

    end

    it 'sem sucesso por erro do servidor' do
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
      allow(Reservation).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      reservation_params = { reservation: { room_id: room.id, start_date: 10.days.from_now,
                            end_date: 15.days.from_now, guest_number: 2}}

      # Act
      post '/api/v1/reservations', params: reservation_params

      # Assert
      expect(response).to have_http_status(500)
    end

  end




end
