class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  
  enum status: [:pendent, :approved, :declined]

  validate :pet_is_not_allowed, :minimum_rent_not_allowed
  validates :start_date, :end_date, :total_guests, :rent_purpose,
            presence: true

  before_save :calculate_proposal_price

  private

  def calculate_proposal_price
    preco = 0
    (start_date..end_date).each do |day|
      preco += calculate_per_day day
    end
    self.total_amount = preco 
  end

  def calculate_per_day(day)
    property.price_ranges.each do |price|
      if day >= price.start_date && day <= price.end_date 
        return price.daily_rate
      end
    end
    property.daily_rate
  end

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

  def count_rent_days
    (end_date - start_date).to_i
  end
end
