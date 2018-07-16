require 'rails_helper'

feature 'Realtor edit property type' do
  scenario 'successfully' do
    realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
    property_type = PropertyType.create(name: 'Apartamento')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Tipos de imóveis'
    visit property_type_index_path
    click_on property_type.name
    fill_in 'Nome', with: 'Casa'
    click_on 'Atualizar'

    expect(page).to have_content('Casa')
  end
  scenario 'and leave blank fields' do
    realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
    property_type = PropertyType.create(name: 'Apartamento')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Tipos de imóveis'
    visit property_type_index_path
    click_on property_type.name
    fill_in 'Nome', with: ''
    click_on 'Atualizar'

    expect(page).to have_content('não pode ficar em branco')
  end

end
