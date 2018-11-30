class HotSalesController < ApplicationController

  def new
    if admin_signed_in?
      @hotsale = HotSale.new

      if params[:prop_id]
        @hotsale.prop_id = params[:prop_id]
      end
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end

  def create
    # Crea la reserva, pero no la guarda
    @hotsale = HotSale.new(params.require(:hot_sale).permit(:fecha_hotsale, :prop_id, :fecha_reserva, :precio))

    # Ajusta para que la fecha sea domingo
    @hotsale.fecha_reserva = @hotsale.fecha_reserva - @hotsale.fecha_reserva.wday
    
    # Verifica que la fecha de reserva sea posterior a la del hot sale
    if (@hotsale.fecha_hotsale > @hotsale.fecha_reserva)
      flash[:alert] = t("hotsale.errors.posterior")
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que la propiedad no tenga una reserva ese dia
    elsif (@hotsale.prop.reserva.where(fecha: @hotsale.fecha_reserva).any?)
      flash[:alert] = t("hotsale.errors.already_reserva")
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que no hay subasta en esa fecha
    elsif (@hotsale.prop.sub.where(fecha_reserva: @hotsale.fecha_reserva).any?)
      flash[:alert] = t("hotsale.errors.already_auction")
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que no hay hot sale en esa fecha
    elsif (@hotsale.prop.hot_sale.where(fecha_reserva: @hotsale.fecha_reserva).any?)
      flash[:alert] = t("hotsale.errors.already_hotsale")
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que la fecha del hot sale sea posterior a hoy
    elsif (Date.today > @hotsale.fecha_hotsale)
      flash[:alert] = t("hotsale.errors.hotsale_posterior")
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    elsif @hotsale.save
      redirect_to @hotsale
    else
      flash[:alert] = @hotsale.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    if admin_signed_in? || usuario_signed_in?
      # Obtiene la lista de pujas
      @hotsale = HotSale.find(params[:id])

      # Se fija si el hot sale esta disponible ahora
      if (@hotsale.fecha_hotsale <= Date.today)
        flash.now[:notice] = "Este Hot Sale se encuentra disponible"
      elsif (@hotsale.fecha_hotsale > Date.today)
        flash.now[:alert] = "Este Hot Sale estara disponible el " + "#{@hotsale.fecha_hotsale}"
      end
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end

  def reservar
    # Se fija si hay un usuario logeado
    if (usuario_signed_in?)

      # Obtiene el hot sale que esta tratando de reservar
      hotsale = HotSale.find(params[:id])


      # Chequea si el usuario ya tiene esa semana ocupada
      if (current_usuario.reserva.where(fecha: hotsale.fecha_reserva).any?)
        flash[:alert] = "Ustes ya tiene una reserva para esta semana"
        redirect_to root_path

      # Si no salio antes hace una reserva
      else

        # Crea la reserva y asigna todos los campos
        reserva_nueva = Reserva.new
        reserva_nueva.fecha = hotsale.fecha_reserva
        reserva_nueva.usuario_id = current_usuario.id
        reserva_nueva.prop_id = hotsale.prop_id
        reserva_nueva.normal=false
        reserva_nueva.save

        # Elimina la publicacion de Hot Sale
        hotsale.destroy

        redirect_to usuario_path(current_usuario)
      end
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end

  def index
    if admin_signed_in? || usuario_signed_in?
      @hot_sales = HotSale.all
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end
end
