class Usuario < ApplicationRecord
	has_many :reserva, dependent: :destroy

	has_many :puja
end
