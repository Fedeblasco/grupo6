class SubsController < ApplicationController

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(params.require(:sub).permit(:fecha_inicio, :fecha_fin, :prop_id, :fecha_reserva, :precio_min))
    @sub.fecha_reserva = @sub.fecha_reserva - @sub.fecha_reserva.wday
    
    if (@sub.fecha_inicio > @sub.fecha_fin)
      flash[:alert] = "La fecha de inicio es mayor a la fecha de fin"
      redirect_to new_sub_path

    elsif (Prop.find(@sub.prop_id).reserva.where(fecha: @sub.fecha_reserva).any?)
      flash[:alert] = "Ya hay una reserva en esa fecha"
      redirect_to new_sub_path

    elsif (Prop.find(@sub.prop_id).sub.where(fecha_reserva: @sub.fecha_reserva).any?)
      flash[:alert] = "Ya hay una subasta en esa fecha"
      redirect_to new_sub_path

    elsif ((@sub.fecha_fin + 6.months) > @sub.fecha_reserva)
      flash[:alert] = "La fecha de reserva es antes de los 6 meses despues que termine la subasta"
      redirect_to new_sub_path

    elsif (Date.today > @sub.fecha_inicio)
      flash[:alert] = "La fecha de subasta debe ser posterior a la fecha actual"
      redirect_to new_sub_path

    elsif @sub.save
      redirect_to subs_path
    else
      flash[:alert] = @sub.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def show
    # Obtiene la lista de pujas
    @sub = Sub.find(params[:id])
    @pujas = Sub.find(params[:id]).puja
  end

  def index
    @subs = Sub.all
  end

  def update
  end

end
