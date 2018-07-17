require 'rails_helper'

feature 'user try edit without login' do
  scenario 'sucessfully' do
    region = Region.create(name: 'Paulista')

    visit edit_region_path(region)
    
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
 
  end
 
end
