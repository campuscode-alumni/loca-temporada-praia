require 'rails_helper'

feature 'search' do
  scenario 'sucessfully' do
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    copacabana = Region.create!(name: 'Copacabana')
    leblon = Region.create!(name: 'Leblon')
    property_type = PropertyType.create(name: 'Apartamento')
    

    properties = Property.create!(title: 'imovel1', property_type: property_type, description: 'descricao', region: copacabana, rent_purpose: 'Casamento', area: 30, room_quantity: 3, 
    accessibility: true, allow_pets: false, realtor: realtor, allow_smokers: false, maximum_guests: 10, minimum_rent: 2, maximum_rent: 10, daily_rate: 10, main_photo: File.new(Rails.root.join('spec', 'support', 'casa.jpg')))

    properties2 = Property.create!(title: 'imovel2', property_type: property_type, description: 'descricao', region: leblon, rent_purpose: 'Formatura', area: 30, room_quantity: 5, 
    accessibility: true, allow_pets: true, realtor: realtor, allow_smokers: true, maximum_guests: 10, minimum_rent: 2, maximum_rent: 10, daily_rate: 10, main_photo: File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
    
    visit root_path
    select 'Copacabana', from: 'Selecione a Região'
    click_on 'Buscar'

    expect(page).to have_content('imovel1')
    expect(page).to have_content('Apartamento')
    expect(page).to have_content('10')
    expect(page).to have_content('Copacabana')
    expect(page).not_to have_content('imovel2')
    expect(page).to have_css("img[src*='casa.jpg']")
  end


  scenario 'find nothing' do
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
    copacabana = Region.create!(name: 'Copacabana')
    leblon = Region.create!(name: 'Leblon')
    property_type = PropertyType.create(name: 'Apartamento')
    

    properties = Property.create!(title: 'imovel1', property_type: property_type, description: 'descricao', region: copacabana, rent_purpose: 'Casamento', area: 30, room_quantity: 3, 
    accessibility: true, allow_pets: false, realtor: realtor, allow_smokers: false, maximum_guests: 10, minimum_rent: 2, maximum_rent: 10, daily_rate: 10, main_photo: File.new(Rails.root.join('spec', 'support', 'casa.jpg')))

   

    visit root_path
    select 'Leblon', from: 'Selecione a Região'
    click_on 'Buscar'

    expect(page).to have_content('Nenhum imovel encontrado para essa regiāo')
    
  end



end
