require 'rails_helper'

describe "O proprietário edita quartos" do
  it "com sucesso" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 0 )
    room = Room.create!(name: 'quarto do beco', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'não', inn: inn )
    # Act
    login_as owner, scope: :owner
    visit root_path
    click_on 'Minha pousada'
    click_on 'Quartos'
    click_on 'Editar quarto'
    fill_in "Nome",	with: "Quarto varanda gourmet"
    click_on 'Atualizar Quarto'
    # Arrange
    expect(page).to have_content 'Quarto varanda gourmet'
    expect(current_path).to eq my_rooms_path

  end

  it "apenas seus quartos" do
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
    room = Room.create!(name: 'quarto do beco', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'não', inn: inn )
    room2 = Room.create!(name: 'quarto lagoa', description: 'quarto com vista mar', dimension: '27',
                        capacity: 5, default_price: '170', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'não', inn: inn2 )
    room3 = Room.create!(name: 'quarto do milhão', description: 'suíte presidencial', dimension: '40',
                        capacity: 10, default_price: '600', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'Sim', inn: inn )
    # Act
    login_as owner, scope: :owner
    visit root_path
    click_on 'Minha pousada'
    click_on 'Quartos'
    # Assert

    expect(page).to have_content 'Quarto: quarto do beco'
    expect(page).to have_content 'Quarto: quarto do milhão'
    expect(page).to have_content 'Preço padrão: 150'
    expect(page).to have_content 'Preço padrão: 600'
    expect(page).not_to have_content 'Nome: quarto lagoa'
    expect(page).not_to have_content 'Preço padrão: 170'
  end

  it "Só o dono logado pode acessar o edit dos quartos" do
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
    room = Room.create!(name: 'quarto do beco', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'não', inn: inn )
    room2 = Room.create!(name: 'quarto lagoa', description: 'quarto com vista mar', dimension: '27',
                        capacity: 5, default_price: '170', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'não', inn: inn2 )
    room3 = Room.create!(name: 'quarto do milhão', description: 'suíte presidencial', dimension: '40',
                        capacity: 10, default_price: '600', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'Sim', inn: inn )
    # Act
    login_as owner2, scope: :owner
    visit edit_room_path(room.id)

    # Assert
    expect(page).to have_content "Você não tem acesso a esse quarto"
    expect(current_path).to eq my_rooms_path
    expect(page).not_to have_content 'Quarto: quarto do beco'
    expect(page).to have_content 'Quarto: quarto lagoa'
  end




end
