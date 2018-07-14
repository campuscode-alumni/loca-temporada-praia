require 'rails_helper'

feature 'user_sign_in' do
  scenario 'sucessfully' do
    user = User.create!(email: 'usuario@gmail.com', password:'12345678')

    visit root_path
    click_on 'Entrar como cliente'

    fill_in 'Email', with: 'usuario@gmail.com'
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    expect(page).to have_content('usuario@gmail.com')
    expect(page).not_to have_content('Entrar')
    expect(page).to have_content('Sair')

  end
  feature 'user_sign_out' do
    scenario 'sucessfully' do
      user = User.create!(email: 'usuario@gmail.com', password:'12345678')
    
      visit root_path
      click_on 'Entrar como cliente'
    
      fill_in 'Email', with: 'usuario@gmail.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
      click_on 'Sair'
    
      expect(page).not_to have_content('usuario@gmail.com')
      expect(page).to have_content('Entrar como cliente')
      expect(page).not_to have_content('Sair')
  
    end
  end
end
