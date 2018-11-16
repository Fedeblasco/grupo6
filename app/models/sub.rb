class Sub < ApplicationRecord
	belongs_to :prop

	has_many :puja, dependent: :destroy

	# Ordena por fecha de creacion
	default_scope { order(fecha_inicio: :asc) }

	validates :precio_min, presence: true
	validates :fecha_reserva, presence: true
	validates :fecha_inicio, presence: true
	validates :fecha_fin, presence: true
	validates :prop_id, presence: true
end
