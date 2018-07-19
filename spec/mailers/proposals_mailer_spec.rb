require "rails_helper"

RSpec.describe ProposalsMailer, type: :mailer do
  describe "notify_user" do

    it "renders the headers" do
      realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
      user = User.create! email: 'user@email.com', password: '12345678', cpf: '36106370567'
      region = Region.create! name: 'Copacabana'
      property_type = PropertyType.create! name: 'Apartamento'
      property = Property.create! title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                                property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                                area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                                maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg'))
      proposal = Proposal.create! start_date: 5.days.ago, end_date: Time.zone.today, rent_purpose: 'Aluguel de Temporada', total_guests: '10', pet: true, property: property, user: user

    

      mail = ProposalsMailer.notify_user(proposal)

      expect(mail.subject).to eq("Proposta enviada com sucesso")

      expect(mail.to).to eq(["user@email.com"])

      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      realtor = Realtor.create! email: 'realtor@email.com', password: '12345678'
      user = User.create! email: 'user@email.com', password: '12345678', cpf: '36106370567'
      region = Region.create! name: 'Copacabana'
      property_type = PropertyType.create! name: 'Apartamento'
      property = Property.create! title: 'Lindo apartamento 100m da praia', description: 'Um apartamento excelente para férias',
                                property_type: property_type, region: region, rent_purpose: 'Aluguel de Temporada', 
                                area: '30', room_quantity: '2', accessibility: true, allow_pets: true, allow_smokers: true, realtor: realtor,
                                maximum_guests: '15', minimum_rent: '1', maximum_rent: 20, daily_rate: '500.5', main_photo:  File.new(Rails.root.join('spec', 'support', 'casa.jpg'))
      proposal = Proposal.create! start_date: 5.days.ago, end_date: Time.zone.today, rent_purpose: 'Aluguel de Temporada', total_guests: '10', pet: true, property: property, user: user

      mail = ProposalsMailer.notify_user(proposal)

      expect(mail.body.encoded).to match("A sua proposta de #{proposal.id} foi enviada com sucesso e está em análise pelo corretor responsável.")
      expect(mail.body.encoded).to match("Para consultar a sua proposta, clique no")
      expect(mail.body.encoded).to have_link("link", href: proposal_url(proposal))
    
    end
  end
  
end
