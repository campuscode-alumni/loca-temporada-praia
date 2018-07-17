require 'rails_helper'

feature 'User View Proposal' do
   scenario 'successfully' do
    region = Region.create!(name: 'Copacabana')

    property_type = PropertyType.create!(name: 'Apartamento')

    realtor = Realtor.create!(email: 'corretor@corretor.com.br', password: '12345678')

    property = Property.create!(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, realtor: realtor, rent_purpose: 'Aluguel de Temporada',
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))

    user = User.create! email: 'user@email.com', password: '12345678', cpf: '36106370567'

    proposal = Proposal.create!(user: user, start_date: '2018-04-18', end_date: '2018-04-19', total_guests: 10, pet: true, rent_purpose: 'Casamento', property: property)

    visit root_path
    click_on 'Entrar como cliente'

    fill_in 'Email', with: user.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    click_on 'Ver minhas Propostas'

    expect(page).to have_content('2018-04-18')
    expect(page).to have_content('2018-04-19')
    expect(page).to have_content('Casamento')

   end

   scenario 'Filtra visualização das propostas por usuário' do
     region = Region.create!(name: 'Copacabana')

     property_type = PropertyType.create!(name: 'Apartamento')

     realtor = Realtor.create!(email: 'corretor@corretor.com.br', password: '12345678')

     property = Property.create!(title: 'Lindo apartamento 100m da praia', realtor: realtor, description: 'Um apartamento excelente para férias',
                               property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada',
                               area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                               maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))

     user1 = User.create! email: 'user1@email.com', password: '12345678', cpf: '36106370567'

     user2 = User.create! email: 'user2@email.com', password: '12345678', cpf: '74064329848'

     proposal = Proposal.create!(user: user1, start_date: '2018-04-18', end_date: '2018-04-19', total_guests: 10, pet: true, rent_purpose: 'Casamento', property: property)

     proposal2 = Proposal.create!(user: user2, start_date: '2018-05-10', end_date: '2018-05-15', total_guests: 12, pet: false, rent_purpose: 'Formatura', property: property)

     visit root_path
     click_on 'Entrar como cliente'

     fill_in 'Email', with: 'usuario@gmail.com'

     fill_in 'Senha', with: '12345678'

     click_on 'Entrar'
   end
end
