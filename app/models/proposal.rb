class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  
  enum status: [:pendent, :approved, :declined] 

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

end
