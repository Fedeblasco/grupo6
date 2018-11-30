class Prop < ApplicationRecord
	has_one_attached :imgprincipal
	
	has_many_attached :images

	has_many :reserva, dependent: :destroy

	has_many :sub, dependent: :destroy

	has_many :hot_sale, dependent: :destroy


	# Validaciones para que no cree cosas vacias
	validates :nombre, presence: true, length: {minimum: 3, maximum: 255}

	validates :ubicacion, presence: true, length: {minimum: 3, maximum: 255}

	validates :precio, presence: true, numericality: { only_integer: true }
	
	validates :oculto, inclusion: { in: [ true, false ] }
end
