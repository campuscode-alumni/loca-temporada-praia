require 'rails_helper'

feature 'Edit Photo' do
  scenario 'successfully' do
    realtor = Realtor.create(email: 'corretor@gmail.com', password: '12345678')
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: 'corretor@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    
    visit property_path(property) 
    click_on 'Editar'


    fill_in 'Título', with: 'Lindo apartamento 50m da praia'
    fill_in 'Descrição', with: 'Um apartamento excelente para o verão'
    select 'Apartamento', from: 'Tipo do imóvel'
    select 'Copacabana', from: 'Região'
    fill_in 'Finalidade do imóvel', with: 'Aluguel de Verão'
    fill_in 'Área', with: '30'
    fill_in 'Quantidade de cômodos', with: 4
    check 'Possui acessibilidade'
    check 'Aceita animais'
    check 'Aceita fumantes'
    fill_in 'Ocupação máxima', with: 10
    fill_in 'Mínimo de diárias', with: 5
    fill_in 'Máximo de diárias', with: 30
    fill_in 'Valor da diária', with: '550'
    click_on 'Atualizar'
    
    expect(page).to have_css('p', text: 'Imóvel editado com sucesso')
    expect(page).to have_css('h1', text: 'Lindo apartamento 50m da praia')
    expect(page).to have_css('p', text: 'Um apartamento excelente para o verão')
    expect(page).to have_css('li', text: region.name)
    expect(page).to have_css('li', text: property_type.name)
    expect(page).to have_css('li', text: 'Aluguel de Verão')
    expect(page).to have_css('li', text: '30m²')
    expect(page).to have_css('li', text: '4')
    expect(page).to have_css('li', text: 'Possui acessibilidade: Sim')
    expect(page).to have_css('li', text: 'Aceita animais: Sim')
    expect(page).to have_css('li', text: 'Aceita fumantes: Sim')
    expect(page).to have_css('li', text: '10')
    expect(page).to have_css('li', text: '5')
    expect(page).to have_css('li', text: '30')
    expect(page).to have_css('li', text: 'R$ 550')
  end

  scenario 'and leave blank fields' do
    realtor = Realtor.create(email: 'corretor@gmail.com', password: '12345678')
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                              property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                              area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                              maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: 'corretor@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    visit property_path(property)

    click_on 'Editar'
    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Finalidade do imóvel', with: ''
    fill_in 'Área', with: ''
    fill_in 'Quantidade de cômodos', with: ''
    check 'Possui acessibilidade'
    check 'Aceita animais'
    check 'Aceita fumantes'
    fill_in 'Ocupação máxima', with: ''
    fill_in 'Mínimo de diárias', with: ''
    fill_in 'Máximo de diárias', with: ''
    fill_in 'Valor da diária', with: ''
    click_on 'Atualizar'
    

    expect(page).to have_content('não pode ficar em branco')
  end

end
