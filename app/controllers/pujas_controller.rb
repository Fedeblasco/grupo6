class PujasController < ApplicationController

  def new
    @puja = Puja.new(sub_id: params[:id])
  end

  def create
    @puja = Puja.new(params.require(:puja).permit(:valor,:usuario_id,:sub_id))

    puja_mas_fuerte = Sub.find(@puja.sub_id).puja.order("valor desc").first

    cant_pujas_ganadas = 0
    otra_puja = nil

    # Recorre todas las subastas donde el usuario hizo puja, viendo si es el ganador es el
    @puja.usuario.puja.each do |p|
      if p.sub.puja.order('valor desc').first.usuario == @puja.usuario
        cant_pujas_ganadas += 1
        otra_puja = p.sub.puja.order('valor desc').first
      end
    end

    # Verifica que el usuario tenga menos de dos semanas reservadas. Esto incluye las subastas que va gaanando
    if (@puja.usuario.reserva.count + cant_pujas_ganadas >= 2)
      flash[:alert] = "#{@puja.usuario.mail}" + " no tiene semanas libres"
      redirect_to sub_path(@puja.sub_id)

    # Verifica que no tenga reservas esa semana.
    elsif (@puja.usuario.reserva.where(fecha: @puja.sub.fecha_reserva).count != 0)
      flash[:alert] = "#{@puja.usuario.mail}" + " ya tiene una reserva esta semana"
      redirect_to sub_path(@puja.sub_id)

    # Si va ganando otra puja, verifica que no sea la misma semana
    elsif (cant_pujas_ganadas == 1) && (@puja.usuario.reserva.where(fecha: otra_puja.fecha_reserva) != 0)
      flash[:alert] = "#{@puja.usuario.mail}" + " esta ganando una subasta esta misma semana"
      redirect_to sub_path(@puja.sub_id)

    # Verifica que la puja actual sea mayor a la actual
    elsif (@puja.valor < puja_mas_fuerte.valor)
      flash[:alert] = "El valor mínimo de puja es " + "#{puja_mas_fuerte.valor}"
      redirect_to sub_path(@puja.sub_id)

    # Verifica si el que va ganando no sea el mismo usario
    elsif (@puja.usuario_id == puja_mas_fuerte.usuario_id)
      flash[:alert] = "#{@puja.usuario.mail}" + " ya esta ganando esta subasta"
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

