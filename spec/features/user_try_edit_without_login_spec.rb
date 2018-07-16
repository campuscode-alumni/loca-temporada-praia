require 'rails_helper'

feature 'user try edit without login' do
  scenario 'sucessfully' do
    region = Region.create(name: 'Paulista')

    visit edit_region_path(region)
    
    expect(page).to have_content('You need to sign in or sign up before continuing.')
 
  end
 
end
