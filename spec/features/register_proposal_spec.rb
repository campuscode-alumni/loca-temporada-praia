require 'rails_helper'

feature 'Register Proposal' do
  scenario 'successfully' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    

    visit property_path(property) 
    
    click_on 'Fazer proposta'

    fill_in 'Data de entrada', with: '01/10/2018'
    fill_in 'Data de saída', with: '10/10/2018'
    fill_in 'Motivo da locação', with: 'Férias em família'
    fill_in 'Quantidade de hóspedes', with: '11'
    check 'Levarei animais?'

    click_on 'Enviar proposta'

    expect(page).to have_css('p', text: 'Proposta enviada com sucesso')
    expect(page).to have_css('li', text: 'Data de entrada: 01/10/2018')
    expect(page).to have_css('li', text: 'Data de saída: 10/10/2018')
    expect(page).to have_css('li', text: 'Motivo: Férias em família')
    expect(page).to have_css('li', text: 'Quantidade de hóspedes: 11')
    expect(page).to have_css('li', text: 'Levarei animais: Sim')

  end
  scenario 'and leave blank fields' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    

    visit property_path(property) 
    
    click_on 'Fazer proposta'

    fill_in 'Data de entrada', with: ''
    fill_in 'Data de saída', with: ''
    fill_in 'Motivo da locação', with: ''
    fill_in 'Quantidade de hóspedes', with: ''

    click_on 'Enviar proposta'

    expect(page).to have_content('não pode ficar em branco')
  end
end



