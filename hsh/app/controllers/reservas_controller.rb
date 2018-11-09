class ReservasController < ApplicationController

  def index
  	@reservas = Reserva.all
  end

  def new
  end

  def create
  end

end
