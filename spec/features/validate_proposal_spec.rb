require 'rails_helper'

  feature 'Validate Proposal' do
    scenario 'successfully' do
      region = Region.create(name: 'Copacabana')
      property_type = PropertyType.create(name: 'Apartamento')
      realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
      property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                                property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                                area: '30', room_quantity: '2', accessibility: true, allow_pets: false, allow_smokers: true, realtor: realtor,
                                maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
      user = User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')

      visit root_path
      click_on 'Entrar como cliente'

      fill_in 'Email', with: 'usuario@gmail.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
      visit property_path(property) 
      
      click_on 'Fazer proposta'

      fill_in 'Data de entrada', with: '01/10/2018'
      fill_in 'Data de saída', with: '10/10/2018'
      fill_in 'Motivo da locação', with: 'Férias em família'
      fill_in 'Quantidade de hóspedes', with: '11'
      check 'Levarei animais?'

      click_on 'Enviar proposta'

      expect(page).to have_content('Não foi possível enviar a proposta pois este imóvel não aceita animais.')

    end
    scenario 'successfully' do
      region = Region.create(name: 'Copacabana')
      property_type = PropertyType.create(name: 'Apartamento')
      realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
      property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                                property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                                area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                                maximum_guests: '15', minimum_rent: '15', maximum_rent: '20', daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
      user = User.create!(email: 'usuario@gmail.com', password:'12345678', cpf: '36106370567')

      visit root_path
      click_on 'Entrar como cliente'

      fill_in 'Email', with: 'usuario@gmail.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
      visit property_path(property) 
      
      click_on 'Fazer proposta'

      fill_in 'Data de entrada', with: '01/10/2018'
      fill_in 'Data de saída', with: '10/10/2018'
      fill_in 'Motivo da locação', with: 'Férias em família'
      fill_in 'Quantidade de hóspedes', with: '11'
      check 'Levarei animais?'

      click_on 'Enviar proposta'

      expect(page).to have_content('Não foi possível enviar a proposta pois o tempo mínimo não foi respeitado')

    end
end