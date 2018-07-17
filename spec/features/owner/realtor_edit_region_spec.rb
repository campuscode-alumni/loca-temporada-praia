require 'rails_helper'

feature 'Realtor edit region' do
  scenario 'successfully' do
    realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
    region = Region.create(name: 'Paulista')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Regiões'
    visit  region_index_path
    click_on region.name
    fill_in 'Nome', with: 'Copacabana'
    click_on 'Atualizar'

    expect(page).to have_content('Copacabana')
  end

  scenario 'and leave blank fields' do
    realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
    region = Region.create(name: 'Paulista')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'
    click_on 'Regiões'
    visit  region_index_path
    click_on region.name
    fill_in 'Nome', with: ''
    click_on 'Atualizar'

    expect(page).to have_content('não pode ficar em branco')
  end

end
