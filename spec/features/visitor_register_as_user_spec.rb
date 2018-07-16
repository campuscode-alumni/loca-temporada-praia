require 'rails_helper'

feature 'Visitor register as user' do
  scenario 'successfully' do
    
    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'user@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Re-insira a Senha', with: '12345678'
    fill_in 'Cpf', with: '36106370567'
    click_on 'Cadastrar'

    expect(current_path).to eq(root_path)
    expect(page).to have_css('li', text: 'user@email.com')
    expect(page).to have_css('a', text: 'Sair')
    expect(page).not_to have_css('a', text: 'Entrar como cliente')
  end
  
  scenario 'and cpf cant be blank' do
    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'user@email.com'
    fill_in 'Senha', with: '12345678'
    fill_in 'Re-insira a Senha', with: '12345678'
    fill_in 'Cpf', with: ''
    click_on 'Cadastrar'
    within 'div#error_explanation' do
      expect(page).to have_css('li', text: 'Cpf não pode ficar em branco')
    end
  end
  scenario 'and must be unique' do
    User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')

    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'user@email.com'
    fill_in 'Senha', with: '87654321'
    fill_in 'Re-insira a Senha', with: '87654321'
    fill_in 'Cpf', with: '36106370567'
    click_on 'Cadastrar'

    within 'div#error_explanation' do
      expect(page).to have_css('li', text:'Cpf Já Cadastrado')
    end
  end
  scenario 'and cpf must be vaild' do
    visit root_path
    click_on 'Cadastrar-se'
    fill_in 'E-mail', with: 'user@email.com'
    fill_in 'Senha', with: '87654321'
    fill_in 'Re-insira a Senha', with: '87654321'
    fill_in 'Cpf', with: '12345678911'
    click_on 'Cadastrar'
    
    within 'div#error_explanation' do
      expect(page).to have_css('li', text: 'Cpf 12345678911 Inválido')
    end
  end
end