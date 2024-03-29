require 'rails_helper'

describe "Usuário clica em uma pousada" do
  it "e vê seus dados" do
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

    # Act
    visit root_path
    click_on 'Pousada Alegre'

    # Assert
    expect(page).to have_content 'Pousada Alegre'
    expect(page).to have_content 'Telefone: 71999999999'
    expect(page).to have_content 'E-mail: contato@pousadaalegre.com'
    expect(page).to have_content 'Endereço completo: rua da praia bela, Stella, Salvador, BA'
    expect(page).to have_content 'CEP: 4012314123'
    expect(page).to have_content 'Formas de Pagamento: Cartão'
    expect(page).to have_content 'Aceita Animais: Não'
    expect(page).to have_content 'Horarios: Chekc-in: 13:00 Chekc-out: 12:00'
    expect(page).to have_content 'Politicas: Proibido correr na pousada '
    expect(page).to have_content 'Descrição: Pousada a beira mar'
    expect(page).not_to have_content 'Pousada alegre ltda'
    expect(page).not_to have_content '10031312314'
  end

  it "vê os dados dos quartos" do

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
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'Não', inn: inn, status: 0)

    # Act
    visit root_path
    click_on 'Pousada Alegre'

    # Assert
    expect(page).to have_content 'Quartos'
    expect(page).to have_content 'quarto do beco'
    expect(page).to have_content 'Descrição: quarto com vista mar'
    expect(page).to have_content 'Tamanho: 20 m²'
    expect(page).to have_content 'Capacidade: 2'
    expect(page).to have_content 'Preço padrão: 150'
    expect(page).to have_content 'Banheiro: Sim'
    expect(page).to have_content 'Varanda: Sim'
    expect(page).to have_content 'Ar-condicionado: Sim'
    expect(page).to have_content 'Tv: Sim'
    expect(page).to have_content 'Guarda roupa: Sim'
    expect(page).to have_content 'Cofre: Sim'
    expect(page).to have_content 'Acesso a PCD: Não'
  end



end
