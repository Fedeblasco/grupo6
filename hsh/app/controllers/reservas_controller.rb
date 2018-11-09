class ReservasController < ApplicationController

  def index
  	@reservas = Reserva.all
  end

  def new
  	@reserva = Reserva.new
  end

  def create

  	@reserva = Reserva.create(params.require(:reserva).permit(:fecha, :usuario_id, :prop_id))

  	#@reserva.fecha = @reserva.fecha - @reserva.fecha.wday

  	if @reserva.save
  		redirect_to reservas_path
  	else
  		render :new
  	end
  end

end
