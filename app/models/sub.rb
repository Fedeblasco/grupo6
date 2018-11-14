class Sub < ApplicationRecord
	belongs_to :prop

	has_many :puja
	validates :precio_min, presence: true
	validates :fecha_reserva, presence: true
	validates :fecha_inicio, presence: true
	validates :fecha_fin, presence: true
	validates :prop_id, presence: true
end
