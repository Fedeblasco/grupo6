class MainController < ApplicationController

	def index
		
	end

	# Vista para que el admin vea todas las tarjetas de los usuarios
	def tarjetas
		if admin_signed_in?
			@usuarios = Usuario.all
		else
			flash[:alert] = "Usted no tiene permiso para ver esto"
			redirect_to root_path
		end
	end
end
