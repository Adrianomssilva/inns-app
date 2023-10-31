require 'rails_helper'

describe "Usuário visita home" do
  it "com sucesso" do
    # Arrange
    #
    #Act
    visit root_path

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Bem vindo a Inns'

  end


end
