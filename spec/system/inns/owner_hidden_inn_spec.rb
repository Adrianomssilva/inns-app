require 'rails_helper'

describe "Proprietário deixa a pousada" do

  it "publicada" do
    # Act
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 0 )
    # Arrange
    login_as(owner)
    visit root_path
    click_on "Minha pousada"
    click_on 'Publicar'
    # Act
    expect(current_path).to eq my_inn_path
    expect(page).to have_content 'Status: published'

  end
  it "habilitada" do
    # Act
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 2 )
    # Arrange
    login_as(owner)
    visit root_path
    click_on "Minha pousada"
    click_on 'Esconder'
    # Act
    expect(current_path).to eq my_inn_path
    expect(page).to have_content 'Status: hidden'
    expect(page).to have_content 'Sua Pousada saiu do ar!'

  end


end
