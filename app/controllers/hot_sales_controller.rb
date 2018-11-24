class HotSalesController < ApplicationController

  def new
    @hotsale = HotSale.new
  end

  def create
    # Crea la reserva, pero no la guarda
    @hotsale = HotSale.new(params.require(:hot_sale).permit(:fecha_hotsale, :prop_id, :fecha_reserva, :precio))

    # Ajusta para que la fecha sea domingo
    @hotsale.fecha_reserva = @hotsale.fecha_reserva - @hotsale.fecha_reserva.wday
    
    # Verifica que la fecha de reserva sea posterior a la del hot sale
    if (@hotsale.fecha_hotsale > @hotsale.fecha_reserva)
      flash[:alert] = "La fecha de reserva debe ser posterior a la fecha del hotsale"
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que la propiedad no tenga una reserva ese dia
    elsif (@hotsale.prop.reserva.where(fecha: @hotsale.fecha_reserva).any?)
      flash[:alert] = "Ya hay una reserva en esa fecha"
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que no hay subasta en esa fecha
    elsif (@hotsale.prop.sub.where(fecha_reserva: @hotsale.fecha_reserva).any?)
      flash[:alert] = "Ya hay una subasta en esa fecha"
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que no hay hot sale en esa fecha
    elsif (@hotsale.prop.hot_sale.where(fecha_reserva: @hotsale.fecha_reserva).any?)
      flash[:alert] = "Ya hay un Hot Sale en esa fecha"
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    # Verifica que la fecha del hot sale sea posterior a hoy
    elsif (Date.today > @hotsale.fecha_hotsale)
      flash[:alert] = "La fecha de Hot Sale debe ser posterior a la fecha actual"
      redirect_to new_hot_sale_path(:prop_id => @hotsale.prop_id)

    elsif @hotsale.save
      redirect_to @hotsale
    else
      flash[:alert] = @hotsale.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    # Obtiene la lista de pujas
    @hotsale = HotSale.find(params[:id])

    # Se fija si el hot sale esta disponible ahora
    if (@hotsale.fecha_hotsale <= Date.today)
      flash.now[:notice] = "Este Hot Sale se encuentra disponible"
    elsif (@hotsale.fecha_hotsale > Date.today)
      flash.now[:alert] = "Este Hot Sale estara disponible el " + "#{@hotsale.fecha_hotsale}"
    end
  end

  def index
    @hotsale = HotSale.all
  end
end
