class Prop < ApplicationRecord
	has_one_attached :imgprincipal, dependent: :destroy
	
	has_many_attached :images, dependent: :destroy

	has_many :reserva, dependent: :destroy

	has_many :sub, dependent: :destroy
end
