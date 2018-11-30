class ReservasController < ApplicationController

  def index

    if admin_signed_in?
      @reservas = Reserva.all
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
      
  end

  def new

    # Verifica que el usuario este logeado y sea admin

    if usuario_signed_in? && current_usuario.vip
    	@reserva = Reserva.new

      # Ya define de antemano la propiedad a reservar y el usuario
      # (El usuario es el que este logeado actualmente en el sistema)
      @reserva.prop_id = params[:prop_id]
      @reserva.usuario_id = current_usuario.id
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end

  def create

    # Verifica que el usuario sea VIP
    if Usuario.find(params[:reserva][:usuario_id]).vip

    	@reserva = Reserva.new(params.require(:reserva).permit(:fecha, :usuario_id, :prop_id))

      # La fecha guardada va a ser el principio de la semana, domingo
    	@reserva.fecha = @reserva.fecha - @reserva.fecha.wday

      # Si hay una reserva en esa fecha, da un error
      if @reserva.prop.reserva.where(fecha: @reserva.fecha).any?
        flash[:alert] = "Ya hay una reserva en esta fecha"
        redirect_to new_reserva_path(params[:reserva][:prop_id])

      # Verifica que la fecha sea 6 meses posterior a la actual
      elsif (Date.today + 6.months >= @reserva.fecha)
        flash[:alert] = "La reserva debe ser 6 meses posterior a la actual"
        redirect_to new_reserva_path(params[:reserva][:prop_id])

      # Si hay una subasta en esa fecha, da un error
      elsif @reserva.prop.sub.where(fecha_reserva: @reserva.fecha).any?
        flash[:alert] = "Ya hay una subasta en esta fecha"
        redirect_to new_reserva_path(params[:reserva][:prop_id])

      # Si la propiedad esta oculta, tiro un mensaje de error
      elsif @reserva.prop.oculto
        flash[:alert] = "Esta propiedad no puede ser reservada en este momento"
        redirect_to new_reserva_path(params[:reserva][:prop_id])

      # Verificaciones del usuario

      # Verifica que no tenga mas de dos reservas
      elsif @reserva.usuario.reserva.all.count >= 2
        flash[:alert] = "Usted no tiene mas semanas disponibles"
        redirect_to new_reserva_path(params[:reserva][:prop_id])

      # Verifica que no tenga una reserva en esa fecha
      elsif @reserva.usuario.reserva.where(fecha: @reserva.fecha).any?
        flash[:alert] = "Usted ya tiene una reserva en esa fecha"
        redirect_to new_reserva_path(params[:reserva][:prop_id])

      # Trata de guardar, si no puede, muestra una alerta 
      elsif @reserva.save
    		redirect_to usuario_path(@reserva.usuario_id)
    	else
        flash[:alert] = "Error al guardar"
        redirect_to new_reserva_path(params[:reserva][:prop_id])
      end
  	
    # Si no es VIP, avisa
    else
      flash[:alert] = "Usted no es VIP, no puede realizar una reserva"
      redirect_to propiedad_path(params[:reserva][:prop_id])
    end
  end

  def destroy
    usuario_id = Reserva.find(params[:id]).usuario_id

    if usuario_signed_in? && current_usuario.id == usuario_id
      Reserva.find(params[:id]).destroy
      redirect_to usuario_path(usuario_id)
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end

end
