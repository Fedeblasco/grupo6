class ReservasController < ApplicationController

  def index
  	@reservas = Reserva.all
  end

  def new
  	@reserva = Reserva.new
  end

  def create

  	@reserva = Reserva.new(params.require(:reserva).permit(:fecha, :usuario_id, :prop_id))

    # La fecha guardada va a ser el principio de la semana, domingo
  	@reserva.fecha = @reserva.fecha - @reserva.fecha.wday

    # Si hay una reserva en esa fecha, da un error
    if Prop.find(@reserva.prop_id).reserva.where(fecha: @reserva.fecha).any?
      flash[:alert] = "Ya hay una reserva en esta fecha"
      redirect_to new_reserva_path

    # Si hay una subasta en esa fecha, da un error
    elsif Prop.find(@reserva.prop_id).sub.where(fecha_reserva: @reserva.fecha).any?
      flash[:alert] = "Ya hay una subasta en esta fecha"
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
