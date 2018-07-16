class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :region
  belongs_to :realtor
  has_attached_file :main_photo
  has_many :proposals
  validates_attachment_content_type :main_photo, content_type: /\Aimage\/.*\z/
  validates :title, :room_quantity, :maximum_guests, :minimum_rent,
            :maximum_rent, :daily_rate, :main_photo, :realtor,
            presence: { message: 'não pode ficar em branco' }
end
