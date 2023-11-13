require 'rails_helper'

describe "Usuário faz login como proprietário" do
  it "com sucesso" do
  # Arrange
  owner = Owner.create!(name: 'Adriano', email: 'adriano3@email.com', password: 'password')

  #Act
  visit root_path
  click_on 'Entrar'
  click_on 'Proprietário'
  fill_in "E-mail",	with: "adriano3@email.com"
  fill_in "Senha",	with: "password"
  within ('div.actions') do
    click_on 'Entrar'
  end

  # Assert
  expect(page).to have_content 'Login efetuado com sucesso.'
  expect(owner.email).to eq 'adriano3@email.com'
  expect(page).not_to have_link 'Entrar'
  expect(page).to have_button 'Sair'
  end

  it "e sai com sucesso" do
    # Arrange
  owner = Owner.create!(name: 'Adriano', email: 'adriano3@email.com', password: 'password')

  #Act
  visit root_path
  click_on 'Entrar'
  click_on 'Proprietário'
  fill_in "E-mail",	with: "adriano3@email.com"
  fill_in "Senha",	with: "password"
  within ('div.actions') do
    click_on 'Entrar'
  end
  click_on 'Sair'

  # Assert
  expect(page).to have_content 'Logout efetuado com sucesso.'
  expect(page).not_to have_button 'Sair'
  expect(page).to have_link 'Entrar'
  end
end
