class Proposal < ApplicationRecord
  belongs_to :property
  belongs_to :user
  
  enum status: [:pendent, :approved, :declined] 

  validates :start_date, :end_date, :total_guests, :rent_purpose,
            presence: { message: 'não pode ficar em branco' }
           
  def proposal_price
    return unless start_date || end_date
    dias = ( end_date - start_date).to_i
    preco = dias * property.daily_rate 
    property.price_ranges.each do |price|
      if start_date >= price.start_date && end_date <= price.end_date 
        preco = dias * price.daily_rate
      end
    end  
    preco 
  end

end
