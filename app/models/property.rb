class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :region
  has_attached_file :main_photo

  validates_attachment_content_type :main_photo, content_type: /\Aimage\/.*\z/
  validates :title, :room_quantity, :maximum_guests, :minimum_rent,
            :maximum_rent, :daily_rate, :main_photo,
            presence: { message: 'não pode ficar em branco' }
end
