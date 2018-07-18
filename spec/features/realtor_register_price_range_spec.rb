require 'rails_helper'

feature 'Realtor register price range' do
  scenario 'successfully' do
    region = Region.create(name: 'Copacabana')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    property_type = PropertyType.create(name: 'Apartamento')
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', realtor: realtor,
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    
    visit root_path

    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    
    visit property_path(property)
    click_on 'Cadastrar temporadas'

    fill_in 'Nome', with: 'Carnaval'
    fill_in 'Data de Inicio', with: '12/02/2018'
    fill_in 'Data Final', with: '20/02/2018'
    fill_in 'Preço da diária', with: '1000'
    click_on 'Criar Temporada'

    expect(page).to have_css('h4', text: 'Carnaval')
    expect(page).to have_css('li', text: 'Data de Inicio: 12/02/2018')
    expect(page).to have_css('li', text: 'Data Final: 20/02/2018')
    expect(page).to have_css('li', text: 'Preço da diária: R$ 1.000,00')
  end
  scenario 'and leave fields blank' do
    region = Region.create(name: 'Copacabana')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    property_type = PropertyType.create(name: 'Apartamento')
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', realtor: realtor,
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    
    visit root_path

    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    
    visit property_path(property)
    click_on 'Cadastrar temporadas'

    fill_in 'Nome', with: ''
    fill_in 'Data de Inicio', with: ''
    fill_in 'Data Final', with: ''
    fill_in 'Preço da diária', with: ''
    click_on 'Criar Temporada'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
  scenario 'and end date cant be lower than start date' do
    region = Region.create(name: 'Copacabana')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    property_type = PropertyType.create(name: 'Apartamento')
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', realtor: realtor,
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    
    visit root_path

    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    
    visit property_path(property)
    click_on 'Cadastrar temporadas'

    fill_in 'Nome', with: 'Natal'
    fill_in 'Data de Inicio', with: '25/12/2018'
    fill_in 'Data Final', with: '24/12/2018'
    fill_in 'Preço da diária', with: '8001'
    click_on 'Criar Temporada'

    expect(page).to have_content('não pode ser menor que a data inicial.')    
  end
end