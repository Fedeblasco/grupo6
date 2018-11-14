class Prop < ApplicationRecord
	has_one_attached :imgprincipal, dependent: :destroy
	
	has_many_attached :images, dependent: :destroy

	has_many :reserva, dependent: :destroy

	has_many :sub, dependent: :destroy


	# Validaciones para que no cree cosas vacias
	validates :nombre, presence: true, length: {minimum: 3, maximum: 255}

	validates :ubicacion, presence: true, length: {minimum: 3, maximum: 255}
	
	validates :oculto, inclusion: { in: [ true, false ] }
end
