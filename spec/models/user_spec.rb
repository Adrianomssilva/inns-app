require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Campus obrigatórios" do
    it "nome do usuário" do
      # Arrange
      user = User.new(name: '')

      # Arrange
      user.valid?
      result = user.errors.include?(:name)

      # Assert
      expect(result).to eq true
    end

    it "cpf do usuário" do
      # Arrange
      user = User.new(cpf: '')

      # Arrange
      user.valid?
      result = user.errors.include?(:cpf)

      # Assert
      expect(result).to eq true
    end

  end

end
