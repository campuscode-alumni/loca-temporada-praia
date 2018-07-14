class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  
  enum status: [:pendente, :aprovado, :recusado] 

  validates :start_date, :end_date, :total_guests, :rent_purpose, :pet,
            presence: { message: 'não pode ficar em branco' }
end
