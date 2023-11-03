require 'rails_helper'


describe "Usuário Entra na plataforma e se cadastra como Prorpietário" do
  it "com sucesso" do
    # Arrange
    #
    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Proprietário'
    click_on 'Criar Conta'
    fill_in "Nome",	with: "Adriano"
    fill_in "E-mail",	with: "adriano22@email.com"
    fill_in "Senha",	with: "password"
    fill_in "Confirme sua senha",	with: "password"
    click_on 'Criar Conta'

    #Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    owner = Owner.last
    expect(owner.name).to eq 'Adriano'
  end

end
