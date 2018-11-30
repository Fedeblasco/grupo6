class Reserva < ApplicationRecord
	belongs_to :prop
	belongs_to :usuario

	# Opcional, por si se atribuyo a partir de una subasta
	has_one :sub_fin, dependent: :destroy
	validates :normal, inclusion: { in: [ true, false ] }
end
