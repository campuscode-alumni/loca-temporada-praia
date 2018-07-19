require 'rails_helper'

feature 'Register Proposal' do
  scenario 'successfully' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    user = User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')

    visit root_path
    click_on 'Entrar como cliente'

    fill_in 'Email', with: 'usuario@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    visit property_path(property) 
    
    click_on 'Fazer proposta'

    fill_in 'Data de entrada', with: '01/10/2018'
    fill_in 'Data de saída', with: '10/10/2018'
    fill_in 'Motivo da locação', with: 'Férias em família'
    fill_in 'Quantidade de hóspedes', with: '11'
    check 'Levarei animais?'

    click_on 'Enviar proposta'

    expect(page).to have_css('p', text: 'Proposta enviada com sucesso')
    expect(page).to have_css('li', text: 'Data de inicio: 01/10/2018')
    expect(page).to have_css('li', text: 'Data final: 10/10/2018')
    expect(page).to have_css('li', text: 'Motivo: Férias em família')
    expect(page).to have_css('li', text: 'Número de visitantes: 11')
    expect(page).to have_css('li', text: 'Permitido Animais: Sim')

  end
  scenario 'and leave blank fields' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    user = User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')

    visit root_path
    click_on 'Entrar como cliente'

    fill_in 'Email', with: 'usuario@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    visit property_path(property) 
    
    click_on 'Fazer proposta'

    fill_in 'Data de entrada', with: ''
    fill_in 'Data de saída', with: ''
    fill_in 'Motivo da locação', with: ''
    fill_in 'Quantidade de hóspedes', with: ''

    click_on 'Enviar proposta'

    expect(page).to have_content('não pode ficar em branco')
  end
  scenario 'and total amount of proposal is calculated' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                              maximum_guests: '15', minimum_rent: 1, maximum_rent: 20, daily_rate: '500.2', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    user = User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')
    price_range = PriceRange.create!(start_date: '01/12/2018', end_date: '31/12/2018', description: 'Final de Ano', daily_rate: '1000.5', property: property)

    visit root_path
    click_on 'Entrar como cliente'

    fill_in 'Email', with: 'usuario@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    visit property_path(property) 
    
    click_on 'Fazer proposta'

    fill_in 'Data de entrada', with: '01/12/2018'
    fill_in 'Data de saída', with: '11/12/2018'
    fill_in 'Motivo da locação', with: 'Férias em família'
    fill_in 'Quantidade de hóspedes', with: '11'
    check 'Levarei animais?'

    click_on 'Enviar proposta'

    expect(page).to have_css('li', text: 'Total da proposta: R$ 11.005,50')
  end
  scenario 'and calculate half season ' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                              maximum_guests: '15', minimum_rent: 1, maximum_rent: 20, daily_rate: '5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    user = User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')
    PriceRange.create!(start_date: '11/02/2018', end_date: '20/02/2018', description: 'Carnaval', daily_rate: '5', property: property)
    price_range = PriceRange.create!(start_date: '11/12/2018', end_date: '31/12/2018', description: 'Final de Ano', daily_rate: '10', property: property)

    visit root_path
    click_on 'Entrar como cliente'

    fill_in 'Email', with: 'usuario@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    visit property_path(property)
    
    click_on 'Fazer proposta'

    fill_in 'Data de entrada', with: '01/12/2018'
    fill_in 'Data de saída', with: '21/12/2018'
    fill_in 'Motivo da locação', with: 'Férias em família'
    fill_in 'Quantidade de hóspedes', with: '11'
    check 'Levarei animais?'

    click_on 'Enviar proposta'

    expect(page).to have_css('li', text: 'Total da proposta: R$ 160,00')
  end


end
