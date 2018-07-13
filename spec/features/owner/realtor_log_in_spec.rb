require 'rails_helper'

feature 'Realtor log in' do
  scenario 'successfully' do
    realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    expect(page).to have_content(realtor.email)
    expect(page).to have_content('Sair')
  end

  scenario 'insuccessfully' do
    realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: 'realtor@alugatemporada.com'
    fill_in 'Senha', with: '123'
    click_on 'Entrar'

    expect(page).to have_content('E-mail ou senha incorretos')
    expect(page).to have_content('Entrar')
  end
end