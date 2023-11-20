require 'rails_helper'

describe "Proprietário cria sua pousada" do

  it "chega na página de cadastro" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')

    # Act
    login_as owner, scope: :owner
    visit root_path
    click_on 'Minha pousada'
    click_on 'Criar pousada'

    # Assert
    expect(page).to have_content 'Nome Fantasia'
    expect(page).to have_content 'Razão Social'
    expect(page).to have_content 'CNPJ'
    expect(page).to have_content 'Telefone'
    expect(page).to have_content 'E-mail'
    expect(page).to have_content 'Endereço'
    expect(page).to have_content 'Bairro'
    expect(page).to have_content 'Cidade'
    expect(page).to have_content 'Estado'
    expect(page).to have_content 'CEP'
    expect(page).to have_content 'Formas de Pagamento'
    expect(page).to have_content 'Aceita Animais'
    expect(page).to have_content 'Políticas'
    expect(page).to have_content 'Entrada'
    expect(page).to have_content 'Saída'


  end

  it "e cria com sucesso" do
    # Arrange
    owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
    owner2 = Owner.create!(name: 'Bia', email:'bia@email.com', password: 'password')

    # Act
    login_as owner, scope: :owner
    visit root_path
    click_on 'Minha pousada'
    click_on 'Criar pousada'
    fill_in "Nome Fantasia",	with: "Pousada Paraíso"
    fill_in "Razão Social",	with: "Pousada Paraíso LTDA"
    fill_in "CNPJ",	with: "1234121000140"
    fill_in "Telefone",	with: "71999999999"
    fill_in "E-mail",	with: "contato@pousadaparaiso.com"
    fill_in "Endereço",	with: "Rua das palmeiras"
    fill_in "Bairro",	with: "Brotas"
    fill_in "Cidade",	with: "Aracaju"
    fill_in "Estado",	with: "SE"
    fill_in "CEP",	with: "40283100"
    select 'Dinheiro Cartão Pix', from: 'Formas de Pagamento'
    select 'Sim', from: 'Aceita Animais'
    fill_in "Políticas",	with: "hauhdaushduahduahudhasudhaudhaudhausdh"
    fill_in "Entrada",	with: "10:00"
    fill_in "Saída",	with: "13:00"
    fill_in "Descrição",	with: "pousada a beira mar, ideal para toda família"
    click_on 'Criar Pousada'
    inn = Inn.last

    # Assert
    expect(current_path).to eq  my_inn_path
    expect(page).to have_content  "Pousada cadastrada com sucesso!"
    expect(inn.owner.name).to eq 'Bianca'
    expect(inn.owner.name).not_to eq 'Bia'
    expect(page).to have_content 'Pousada Paraíso'
    expect(page).to have_content 'CNPJ: 1234121000140'
    expect(page).to have_content 'Telefone: 71999999999'
    expect(page).to have_content 'Endereço completo: Rua das palmeiras, Brotas, Aracaju, SE'
  end



end
