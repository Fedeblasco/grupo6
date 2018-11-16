namespace :finalizar_subasta do

	desc "Finalizar las subastas. Ver quien gano, asignarle la reserva."

	task :finalizar_subasta => :environment do

		# Obtiene todas las subastas
		subastas = Sub.all

		# Recorre todas las subastas a ver si terminaron
		# subastas.first.each do |s|
		s = Sub.first
			# Si la fecha de la subasta es pasada termina la subasta
			if (s.fecha_fin < Date.today)
				
				# Si la subasta tiene pujas y la mayor supera el monto minimo procesa
				# si no destruye la subasta solamente
				if ((s.puja) && (s.puja.order('valor desc').first.valor >= s.precio_min))

					# Obtiene el usuario ganador
					ganador = s.puja.order('valor desc').first.usuario

					# Crea la nueva reserva y le asigna todos los valores
					reserva = Reserva.new
					reserva.fecha = s.fecha_reserva
					reserva.prop = s.prop
					reserva.usuario = ganador

					# Guarda ahora porque va a necesitar el id, pero se sigue modificando abajo
					reserva.save

					# Crea la subasta finalziada
					sub_fin = SubFin.new
					sub_fin.valor = s.puja.order('valor desc').first.valor
					sub_fin.usuario = ganador
					sub_fin.reserva = reserva

					# Guarda la subasta finalizada
					sub_fin.save

					# Agrega la relacion con la subasta finalziada y guarda
					reserva.sub_fin = sub_fin
					reserva.save
				end

				# Destruye la subasta, mierda la hace, la revienta a balasos
				s.destroy
			end
		#end
	end
end
