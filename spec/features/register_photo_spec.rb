require 'rails_helper'

feature 'Register Photo' do
  scenario 'successfully' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'

    visit root_path

    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    visit new_property_path

    click_on 'Cadastrar imóvel'
    fill_in 'Título', with: 'Lindo apartamento 100m da praia'
    fill_in 'Descrição', with: 'Um apartamento excelente para férias'
    select 'Apartamento', from: 'Tipo do imóvel'
    select 'Copacabana', from: 'Região'
    fill_in 'Finalidade do imóvel', with: 'Aluguel de Temporada'
    fill_in 'Área', with: '30'
    fill_in 'Quantidade de cômodos', with: 2
    check 'Possui acessibilidade'
    check 'Aceita animais'
    check 'Aceita fumantes'
    fill_in 'Ocupação máxima', with: 15
    fill_in 'Mínimo de diárias', with: 1
    fill_in 'Máximo de diárias', with: 20
    fill_in 'Valor da diária', with: '500.50'
    attach_file('Inserir foto de destaque', Rails.root.join('spec', 'support', 'casa.jpg'))
    click_on 'Cadastrar'

    expect(page).to have_css("img[src*='casa.jpg']")

  end
  scenario 'Cadastra propriedade sem foto' do
    region = Region.create(name: 'Copacabana')
    property_type = PropertyType.create(name: 'Apartamento')
    realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'

    visit root_path
    click_on 'Entrar como corretor'
    fill_in 'E-mail', with: realtor.email
    fill_in 'Senha', with: '12345678'
    click_on 'Entrar'

    visit new_property_path

    click_on 'Cadastrar imóvel'
    fill_in 'Título', with: 'Lindo apartamento 100m da praia'
    fill_in 'Descrição', with: 'Um apartamento excelente para férias'
    select 'Apartamento', from: 'Tipo do imóvel'
    select 'Copacabana', from: 'Região'
    fill_in 'Finalidade do imóvel', with: 'Aluguel de Temporada'
    fill_in 'Área', with: '30'
    fill_in 'Quantidade de cômodos', with: 2
    check 'Possui acessibilidade'
    check 'Aceita animais'
    check 'Aceita fumantes'
    fill_in 'Ocupação máxima', with: 15
    fill_in 'Mínimo de diárias', with: 1
    fill_in 'Máximo de diárias', with: 20
    fill_in 'Valor da diária', with: '500.50'
    click_on 'Cadastrar'

    expect(page).to have_content 'não pode ficar em branco'
  end
end