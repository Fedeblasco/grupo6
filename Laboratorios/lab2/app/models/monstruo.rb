class Monstruo < ActiveRecord::Base
	validates :nombre, presence: true
	validates :nombre, uniqueness: true
	has_many:victimas,dependent: :destroy
end