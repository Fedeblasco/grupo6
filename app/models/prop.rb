class Prop < ApplicationRecord
	has_one_attached :imgprincipal
	has_many_attached :images
	has_many :reserva, dependent: :destroy
	has_many :sub, dependent: :destroy

	# Validaciones para que no cree cosas vacias
	validates :nombre, presence: true, length: {minimum: 3, maximum: 255}
	validates :ubicacion, presence: true, length: {minimum: 3, maximum: 255}
	validates :oculto, inclusion: { in: [ true, false ] }
	validates :hotsale, inclusion: { in: [ true, false ] }
end
