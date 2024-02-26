# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# INN's Owners
  owner = Owner.create!(name: 'Bianca', email:'bianca@email.com', password: 'password')
  owner1 = Owner.create!(name: 'Adriano', email:'adriano@email.com', password: 'password')
  owner2 = Owner.create!(name: 'João', email:'joão@email.com', password: 'password')

# Inns
  inn = Inn.create!(brand_name: 'Pousada Alegre', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaalegre.com',
                      address: 'rua da praia bela', neighborhood: 'Stella', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner,
                      status: 2 )
  inn1 = Inn.create!(brand_name: 'Pousada Sempre Aqui', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@sempreaqui.com',
                      address: 'rua do pinheiro', neighborhood: 'Bairro da roça', city: 'Limeira', state: 'SP',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner1,
                      status: 2 )
  inn2 = Inn.create!(brand_name: 'Pousada Verão', corporate_name: 'Pousada alegre ltda',
                      registration_number: '10031312314', phone: '71999999999', email: 'contato@pousadaverao.com',
                      address: 'rua do buracão', neighborhood: 'Rio Vermelho', city: 'Salvador', state: 'BA',
                      payment_options: 'Cartão',pets: 'Não', description: 'Pousada a beira mar', cep: '4012314123',
                      policies: 'Proibido correr na pousada', check_in: '13:00', check_out: '12:00', owner: owner2,
                      status: 2 )

# inn rooms
  Room.create!(name: 'quarto azul', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'não', inn: inn )
  Room.create!(name: 'quarto lagoa', description: 'quarto com vista mar', dimension: '27',
                        capacity: 5, default_price: '170', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'Sim', inn: inn )
# inn1 rooms
  Room.create!(name: 'quarto azul', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'não', inn: inn1 )
  Room.create!(name: 'quarto lagoa', description: 'quarto com vista mar', dimension: '27',
                        capacity: 5, default_price: '170', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'Sim', inn: inn1 )
# inn2 rooms
  Room.create!(name: 'quarto azul', description: 'quarto com vista mar', dimension: '20',
                        capacity: 2, default_price: '150', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'Sim', inn: inn2 )
  Room.create!(name: 'quarto lagoa', description: 'quarto com vista mar', dimension: '27',
                        capacity: 5, default_price: '170', bathroom: 'Sim', balcony: 'Sim',
                        air_conditioning: 'Sim', tv: 'Sim', wardrobe: 'Sim', safe: 'Sim', pcd: 'Sim', inn: inn2 )


#  Users logins
  User.create!(name: 'Gabriel', cpf: '00000000000', email: 'login@email.com', password: 'password')
