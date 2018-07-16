require 'rails_helper'

feature 'View Proposals' do
  scenario 'successfully' do

    realtor = Realtor.create!(email: 'corretor@corretor.com.br', password: '12345678')

    region = Region.create!(name: 'Copacabana')
    property_type = PropertyType.create!(name: 'Apartamento')
    user = User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')
    property = Property.create!(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                                property_type: property_type, region: region, realtor: realtor, rent_purpose: 'Aluguel de Temporada', 
                                area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                                maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))

    proposal = Proposal.create!(start_date: '2018-04-18', end_date: '2018-04-19', total_guests: 10, pet: true, rent_purpose: 'Casamento', property: property, user: user)
    
    visit new_realtor_session_path
    fill_in 'E-mail', with: 'corretor@corretor.com.br'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Ver propostas'
    expect(page).to have_content('2018-04-18')
    expect(page).to have_content('2018-04-19')
    expect(page).to have_content('10')
    expect(page).to have_content('true')
    expect(page).to have_content('Casamento')

    click_on 'Aprovar'

    click_on 'Rejeitar'

  end
end
