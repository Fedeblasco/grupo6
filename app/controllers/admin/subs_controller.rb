class Admin::SubsController < ApplicationController
  before_action :check_access

  def check_access
    redirect_to subs_url and return unless admin_signed_in?
  end

  def index
    @subs = Sub.all
  end

  def show
    # Obtiene la lista de pujas
    @sub = Sub.find(params[:id])
    @pujas = Sub.find(params[:id]).puja.order("valor desc")

    # Se fija si la subasta esta disponible ahora
    if (@sub.fecha_inicio <= Date.today) && ( Date.today <= @sub.fecha_fin)
      flash.now[:notice] = "Esta subasta se encuentra disponible hasta " + "#{@sub.fecha_fin}"
    elsif (@sub.fecha_inicio > Date.today)
      flash.now[:alert] = "Esta subasta estara disponible el " + "#{@sub.fecha_inicio}"
    elsif (Date.today > @sub.fecha_fin)
      flash.now[:alert] = "Esta subasta termino. Los ganadores se conoceran a la brevedad"
    end
  end

end
