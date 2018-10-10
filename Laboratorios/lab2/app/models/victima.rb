class Victima < ApplicationRecord
	belongs_to :monstruo
	default_scope -> { order("nombre asc") }
	scope :mayores, -> { where("edad > 25") }
end