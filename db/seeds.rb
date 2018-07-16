# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
realtor = Realtor.create!(email: 'admin@corretor.com.br', password: '12345678')
region = Region.create!(name: 'Copacabana')
property_type = PropertyType.create!(name: 'Apartamento')
property = Property.create!(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                                property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                                area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                                maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))

proposal = Proposal.create!(start_date: '2018-04-18', end_date: '2018-04-19', total_guests: 10, pet: true, rent_purpose: 'Casamento', property: property)
  puts 'Cadastrando Propriedade e Proposta'