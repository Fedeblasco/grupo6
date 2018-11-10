class Prop < ApplicationRecord
	has_one_attached :imgprincipal
	
	has_many_attached :images

	has_many :reserva

	has_many :sub
end
