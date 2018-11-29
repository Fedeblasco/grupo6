class Carousel < ApplicationRecord
	has_one_attached :imageA
	
	has_one_attached :imageB
	
	has_one_attached :imageC
end
