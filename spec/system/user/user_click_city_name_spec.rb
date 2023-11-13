require 'rails_helper'

describe "O usuário vê na tela inicial nome de cidades" do

  it 'e clica em um deles' do
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
    #Act
    visit root_path
    click_on 'Salvador'

    #Assert
    expect(page).to have_content 'Resultado da busca por: Salvador'
    expect(page).to have_content 'Pousada Alegre'
    expect(page).to have_content 'Pousada feliz'
  end
  it 'e clica em uma cidade e não vê a outra' do
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
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Rio de Janeiro', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner2,
                      status: 2 )
    #Act
    visit root_path
    click_on 'Rio de Janeiro'

    #Assert
    expect(page).to have_content 'Resultado da busca por: Rio de Janeiro'
    expect(page).not_to have_content 'Pousada Alegre'
    expect(page).to have_content 'Pousada feliz'
  end

end
