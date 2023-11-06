require 'rails_helper'

describe "Dono de pousada add quarto" do


  it "com sucesso" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 0 )
    #Act
    login_as(owner)
    visit root_path
    click_on 'Minha pousada'
    click_on 'Quartos'
    click_on 'Adicionar quarto'
    fill_in "Nome",	with: "quarto do beco"
    fill_in "Dimensão",	with: "30"
    fill_in "Descrição",	with: "quarto com vista para o mar"
    fill_in "Capacidade",	with: "2"
    fill_in "Preço padrão",	with: "150"
    select "Sim", from: 'Banheiro próprio'
    select "Sim", from: 'Varanda'
    select "Sim", from: 'Ar-condicionado'
    select "Sim", from: 'TV'
    select "Sim", from: 'Guarda roupa'
    select "Sim", from: 'Cofre'
    select "Não", from: 'PCD'
    click_on 'Criar Quarto'

    #Assert
    expect(page).to have_content 'Quarto: quarto do beco'
    expect(page).to have_content 'Descrição: quarto com vista para o mar'
    expect(page).to have_content 'Capacidade: 2'
    expect(page).to have_content 'Preço padrão: 150'
  end


end
