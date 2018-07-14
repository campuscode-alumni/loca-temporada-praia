class Proposal < ApplicationRecord
  belongs_to :property
  

  validates :start_date, :end_date, :total_guests, :rent_purpose, :pet,
            presence: { message: 'não pode ficar em branco' }
end
