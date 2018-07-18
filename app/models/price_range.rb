class PriceRange < ApplicationRecord
  belongs_to :property
  validate :date_validates
  validates :description, :start_date, :end_date, :daily_rate,presence: true

  def date_validates
    if start_date && end_date && start_date > end_date 
      errors.add(:end_date, 'não pode ser menor que a data inicial.' )
    end
  end
 
end
