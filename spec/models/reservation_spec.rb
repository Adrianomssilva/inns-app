require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "Campus vazios não devem passar" do
    it "teste data de entrada em branco" do
      # Arrange
      reserva = Reservation.new(start_date: " ")

      # Act
      reserva.valid?
      result = reserva.errors.include?(:start_date)

      # Assert
      expect(result).to eq true
    end

    it "teste data de saída em branco" do
      # Arrange
      reserva = Reservation.new(end_date: " ")

      # Act
      reserva.valid?
      result = reserva.errors.include?(:end_date)

      # Assert
      expect(result).to eq true
    end

    it "teste hóspedes em branco" do
      # Arrange
      reserva = Reservation.new(guest_number: " ")

      # Act
      reserva.valid?
      result = reserva.errors.include?(:guest_number)

      # Assert
      expect(result).to eq true


    end

    it "Reserva com datas ocupadas" do
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
    reserva = Reservation.create!(start_date: 2.days.from_now, end_date:7.days.from_now, guest_number: 2, room_id: room.id, status: 0, user_id: user.id)
    reserva2 = Reservation.new(start_date: 2.days.from_now, end_date:7.days.from_now, guest_number: 2, room_id: room.id, user_id: user.id)
    # Act
    reserva2.valid?
    result = reserva2.errors.full_messages

    # Assert
    result.each do |msg|
      expect(msg).to eq "Estas datas não estão disponíveis"
    end
    end

    it "Reserva com data passada" do
    # Arrange

    reserva2 = Reservation.new(start_date: 2.days.ago)
    # Act
    reserva2.valid?
    result = reserva2.errors.include?(:start_date)

    # Assert
    expect(result).to eq true
    end

    it "Reserva com data de saída menor que a de entrada" do
    # Arrange

    reserva2 = Reservation.new(start_date: 7.days.from_now, end_date: 3.days.from_now)
    # Act
    reserva2.valid?
    result = reserva2.errors.include?(:end_date)

    # Assert
    expect(result).to eq true


    end

    it "Reserva com número de hóspedes superior a capacidade do quarto" do
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
    reserva = Reservation.new(start_date: 2.days.from_now, end_date:7.days.from_now, guest_number: 3,
                                  room_id: room.id, user_id: user.id)
    # Act
    reserva.valid?
    result = reserva.errors.full_messages

    # Assert
      result.each do |msg|
        expect(msg).to eq "Capacidade superior ao do quarto"
      end
    end

    it "Reserva tem um cod aleatório" do
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
    reserva = Reservation.new(start_date: 2.days.from_now, end_date:7.days.from_now,
                              guest_number: 2, room_id: room.id, status: 0, user_id: user.id)

    # Act
    reserva.save!
    result = reserva.code

    # Assert
    expect(result).not_to be_empty
    expect(result.length).to eq 8


    end

    it "Reserva tem um cod único" do
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
    reserva = Reservation.create!(start_date: 2.days.from_now, end_date:7.days.from_now,
                              guest_number: 2, room_id: room.id, status: 0, user_id: user.id)
    reserva2 = Reservation.new(start_date: 8.days.from_now, end_date:15.days.from_now,
                              guest_number: 2, room_id: room.id, status: 0, user_id: user.id)

    # Act
    reserva2.save!


    # Assert
    expect(reserva2.code).not_to eq reserva.code


    end

  end

end
