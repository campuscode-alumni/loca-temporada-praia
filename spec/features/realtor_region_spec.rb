require 'rails_helper'

feature 'Edit Region' do
  scenario 'successfully' do
    realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
    region = Region.create(name: 'Copacabana') 
    Region.create(name:'Leblon')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    visit edit_region_path(region)
    fill_in 'Nome', with: 'Leblon'
    click_on 'Atualizar'
    
    

    expect(page).to have_content('Leblon')
  end
end
