require 'rails_helper'

    feature 'Realtor see his properties' do
        scenario 'successfully' do
            realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
            region = Region.create(name: 'Copacabana')
            property_type = PropertyType.create(name: 'Apartamento')
            property = Property.create(title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                                      property_type: property_type, region: region, realtor: realtor, rent_purpose: 'Aluguel de Temporada', 
                                      area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                                      maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
           
            visit root_path
            click_on 'Entrar como corretor'
            fill_in 'E-mail', with: realtor.email
            fill_in 'Senha', with: '12345678'
            click_on 'Entrar'
            click_on 'Propriedades'

            expect(page).to have_content(property.title)    
            expect(page).to have_css("img[src*='casa.jpg']")
            expect(page).to have_content(realtor.email)
            expect(page).to have_content('Sair')        
        
        
        end

        scenario 'unsuccessfully' do
          realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
          realtor2 = Realtor.create(email: 'realtor2@alugatemporada.com', password: '12345678')
          region = Region.create(name: 'Copacabana')
          property_type = PropertyType.create(name: 'Apartamento')
          property2 = Property.create(title: 'Lindo apartamento 100m do centro', description: 'Um apartamento excelente para viagem de negócios',
                                    property_type: property_type, region: region, realtor: realtor2, rent_purpose: 'Aluguel de viagem de Negócios', 
                                    area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                                    maximum_guests: '5', minimum_rent: '1', maximum_rent: 20, daily_rate: '350', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
          
          visit root_path
          click_on 'Entrar como corretor'
          fill_in 'E-mail', with: realtor.email
          fill_in 'Senha', with: '12345678'
          click_on 'Entrar'
          click_on 'Propriedades'

          expect(page).to have_content(realtor.email)
          expect(page).not_to have_content(property2.title)
          expect(page).to have_content('Não existem propriedades cadastradas em seu usuário.')        
      
      
          end
            scenario 'Acess without log in' do
              realtor = Realtor.create(email: 'realtor@alugatemporada.com', password: '12345678')
              realtor2 = Realtor.create(email: 'realtor2@alugatemporada.com', password: '12345678')
              region = Region.create(name: 'Copacabana')
              property_type = PropertyType.create(name: 'Apartamento')
              property2 = Property.create(title: 'Lindo apartamento 100m do centro', description: 'Um apartamento excelente para viagem de negócios',
                                        property_type: property_type, region: region, realtor: realtor2, rent_purpose: 'Aluguel de viagem de Negócios', 
                                        area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true,
                                        maximum_guests: '5', minimum_rent: '1', maximum_rent: 20, daily_rate: '350', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg')))
              
              visit by_realtor_path

              expect(page).not_to have_content('Propriedades')
      
          
          
          end
    end