class PujasController < ApplicationController

  def new
    if usuario_signed_in?
      @puja = Puja.new(sub_id: params[:id])
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end
  end

  def create
    @puja = Puja.new(params.require(:puja).permit(:valor,:usuario_id,:sub_id))

    puja_mas_fuerte = Sub.find(@puja.sub_id).puja.order("valor desc").first
    
    # Verifica que el usuario tenga menos de dos semanas reservadas. Esto incluye las subastas que va gaanando
    if (@puja.usuario.reserva.count >= 2)
      flash[:alert] = "#{@puja.usuario.email}" + " no tiene semanas libres"
      redirect_to sub_path(@puja.sub_id)

    # Verifica que no tenga reservas esa semana.
    elsif (@puja.usuario.reserva.where(fecha: @puja.sub.fecha_reserva).count != 0)
      flash[:alert] = "#{@puja.usuario.email}" + " ya tiene una reserva esta semana"
      redirect_to sub_path(@puja.sub_id)

    # Verifica que la puja actual sea mayor a la actual
    elsif puja_mas_fuerte && (@puja.valor < puja_mas_fuerte.valor)
      flash[:alert] = "El valor mínimo de puja es " + "#{puja_mas_fuerte.valor}"
      redirect_to sub_path(@puja.sub_id)

    # Verifica si el que va ganando no sea el mismo usario
    elsif puja_mas_fuerte && (@puja.usuario_id == puja_mas_fuerte.usuario_id)
      flash[:alert] = "#{@puja.usuario.email}" + " ya esta ganando esta subasta"
      redirect_to sub_path(@puja.sub_id)

    # Verifica que sea la subasta este abierta
    elsif (@puja.sub.fecha_inicio > Date.today) || ( Date.today > @puja.sub.fecha_fin)
      flash[:alert] = "La subasta no esta abierta actualmente"
      redirect_to sub_path(@puja.sub_id)

    # Trata de guardar
    elsif @puja.save
      redirect_to sub_path(@puja.sub_id)
    else
      flash[:alert] = @prop.errors.full_messages.to_sentence
      redirect_to pujar_path(params[:sub_id])
    end
  end

end

