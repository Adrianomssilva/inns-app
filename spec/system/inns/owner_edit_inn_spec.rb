require 'rails_helper'

describe "Prorpietário edita sua pousada" do

  it "com sucesso" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 0 )
    # Act
    login_as(owner)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Editar'
    fill_in "Nome Fantasia",	with: "Pousada Feliz da praia"
    fill_in 'Razão social', with: 'Pousada Feliz empreendimentos'

    # Assert
    expect(page).to have_content 'Pousada Feliz da praia'
    expect(page).to have_content 'Pousada Feliz empreendimentos'
    expect(page).not_to have_content 'Pousada Alegre'
    expect(page).not_to have_content 'Pousada alegre ltda'
    expect(page).to have_content 'Pousada editada com sucesso'

  end


end
