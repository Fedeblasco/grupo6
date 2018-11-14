class Usuario < ApplicationRecord
	has_many :reserva, dependent: :destroy
end
