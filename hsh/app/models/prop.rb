class Prop < ApplicationRecord
	has_one_attached :imgprincipal
	
	has_many_attached :images
end
