class ReservasController < ApplicationController

  def index
  	@reservas = Reserva.all
    if usuario_signed_in?
      remove = []
      @reservas.each do |p|
        if (p.usuario_id != current_usuario.id)
          remove << p
        end
      end
      @reservas = @reservas - remove
    end
  end

  def new
  	@reserva = Reserva.new
  end

  def create

  	@reserva = Reserva.new(params.require(:reserva).permit(:fecha, :usuario_id, :prop_id))

    # La fecha guardada va a ser el principio de la semana, domingo
  	@reserva.fecha = @reserva.fecha - @reserva.fecha.wday

    # Si hay una reserva en esa fecha, da un error
    if @reserva.prop.reserva.where(fecha: @reserva.fecha).any?
      flash[:alert] = "Ya hay una reserva en esta fecha"
      redirect_to new_reserva_path

    # Si hay una subasta en esa fecha, da un error
    elsif @reserva.prop.sub.where(fecha_reserva: @reserva.fecha).any?
      flash[:alert] = "Ya hay una subasta en esta fecha"
      redirect_to new_reserva_path

    # Si la propiedad esta oculta, tiro un mensaje de error
    elsif @reserva.prop.oculto
      flash[:alert] = "Esta propiedad no puede ser reservada en este momento"
      redirect_to new_reserva_path


    # Trata de guardar, si no puede, muestra una alerta 
    elsif @reserva.save
  		redirect_to reservas_path
  	else
      flash[:alert] = "Error al guardar"
  		render :new
  	end

  end

end
