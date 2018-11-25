class Admin::ReservasController < ApplicationController
  before_action :authenticate_admin!

  def index
    @reservas = Reserva.all
  end

end
