require 'rails_helper'

RSpec.describe Inn, type: :model do
  describe "text owner em pousada" do
    it "passar pousada sem dono" do
      # Arrange
    inn = Inn.new(brand_name: 'teste')
    # Act
    result = inn.valid?
    # Assert
    expect(result).to eq false
    end


  end

end
