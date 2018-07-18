class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  
  enum status: [:pendent, :approved, :declined] 
  
  validates :start_date, :end_date, :total_guests, :rent_purpose,
  presence: { message: 'não pode ficar em branco' }
  
  validate :pet_is_not_allowed, :minimum_rent_not_allowed

  def pet_is_not_allowed
    if pet == true && property.allow_pets == false
      errors.add(:pet, "Não foi possível enviar a proposta pois este imóvel não aceita animais.")
    end
  end

  def minimum_rent_not_allowed
    if start_date.present? && end_date.present? && property.minimum_rent > count_rent_days
      errors.add(:end_date, "Não foi possível enviar a proposta pois o tempo mínimo não foi respeitado")
    end
  end

  private
  def count_rent_days
    (end_date - start_date).to_i
  end
end
