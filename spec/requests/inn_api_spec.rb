require 'rails_helper'

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
        get "/api/v1/inns/search", params: query
      # Assert
        expect(response).to have_http_status(200)
        expect(response.content_type).to include 'application/json'
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq 1
        expect(json_response[0]["brand_name"]).to eq 'Pousada Alegre'
    end


  end

  context "Get /api/v1/inn.id/rooms" do
    it 'com sucesso' do

    end
  end


end
