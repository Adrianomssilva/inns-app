require 'rails_helper'

describe "Um dono  pousada pode add preços personalizados para temporadas" do
it "com sucesso" do
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
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim',
                        pcd: 'não', inn: inn,status:2 )
  # Act
  login_as(owner)
  visit root_path
  click_on 'Minha pousada'
  click_on 'Quartos'
  click_on 'Preços personalizados'
  fill_in "Valor",	with: "200"
  fill_in "Data início",	with: "10/11/2023"
  fill_in "Data fim",	with: "20/11/2023"
  click_on 'Criar Preço'

  # Assert
    expect(page).to have_content 'Valor: 200'
    expect(page).to have_content 'Data início: 2023-11-10'
    expect(page).to have_content 'Data fim: 2023-11-20'


end




end
