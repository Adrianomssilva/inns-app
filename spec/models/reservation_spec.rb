require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "Campus vazios não devem passar" do
    it "teste data de entrada" do
      # Arrange
      reserva = Reservation.new(start_date: " ")

      # Act
      reserva.valid?
      result = reserva.errors.include?(:start_date)

      # Assert
      expect(result).to eq true


    end
    it "teste data de saída" do
      # Arrange
      reserva = Reservation.new(end_date: " ")

      # Act
      reserva.valid?
      result = reserva.errors.include?(:end_date)

      # Assert
      expect(result).to eq true


    end
    it "teste hóspedes" do
      # Arrange
      reserva = Reservation.new(guest_number: " ")

      # Act
      reserva.valid?
      result = reserva.errors.include?(:guest_number)

      # Assert
      expect(result).to eq true


    end


  end

end
