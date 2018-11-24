class HotSale < ApplicationRecord
	belongs_to :prop

	# Fuerza a que
	validates :precio, presence: true
	validates :fecha_hotsale, presence: true
	validates :fecha_reserva, presence: true
	validates :prop_id, presence: true
end
