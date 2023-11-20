require 'rails_helper'

describe "Prorpietário edita sua pousada" do

  it "com sucesso" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 0 )
    # Act
    login_as owner, scope: :owner
    visit root_path
    click_on 'Minha pousada'
    click_on 'Editar'
    fill_in "Nome Fantasia",	with: "Pousada Feliz da praia"
    fill_in 'Razão Social', with: 'Pousada Feliz empreendimentos'
    click_on 'Atualizar Pousada'

    # Assert
    expect(page).to have_content 'Pousada Feliz da praia'
    expect(page).to have_content 'Pousada Feliz empreendimentos'
    expect(page).not_to have_content 'Pousada Alegre'
    expect(page).not_to have_content 'Pousada alegre ltda'
    expect(page).to have_content 'Pousada editada com sucesso'

  end

  it "Sem sucesso" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 0 )
    # Act
    login_as owner, scope: :owner
    visit root_path
    click_on 'Minha pousada'
    click_on 'Editar'
    fill_in "Nome Fantasia",	with: ""
    fill_in 'Razão Social', with: ''
    click_on 'Atualizar Pousada'

    # Assert
    expect(page).not_to have_content 'Pousda autualizada com sucesso'
    expect(page).to have_content 'Não foi possível editar a pousada.'

  end
  it "Outro dono tenta editar a pousada" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    owner2 = Owner.create!(name: 'Adriano', email:'adr@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 0 )
    inn2 = Inn.create!(brand_name: 'Pousada feliz', corporate_name: 'Pousada feliz ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner2,
                      status: 0 )
    # Act
    login_as owner2, scope: :owner
    visit edit_inn_path(inn.id)

    # Assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem acesso a essa Pousada'

  end


end
