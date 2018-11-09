class Reserva < ApplicationRecord
	belongs_to :prop
	belongs_to :usuario
end
