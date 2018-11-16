class Puja < ApplicationRecord
	belongs_to :usuario
	belongs_to :sub

	validates :valor, presence: true, numericality: true
	validates :usuario_id, presence: true
	validates :sub_id, presence: true
end
