require 'rails_helper'

feature 'Approval proposal' do
  scenario 'successfully' do
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    user = User.create! email: 'user@email.com', password: '12345678'
    region = Region.create! name: 'Copacabana'
    property_type = PropertyType.create! name: 'Apartamento'
    property = Property.create! title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg'))
    proposal = Proposal.create! start_date: 2.days.before, end_date: 2.days.after, rent_purpose: 'Aluguel de Temporada', total_guests: '10', pet: true, property: property, user: user

    visit root_path

    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    
    visit proposal_path(proposal)
    click_on 'Aprovar proposta'

    expect(page).to have_content('Proposta aprovada com sucesso!')
    expect(current_path).to eq(property_path(property))

  end
end