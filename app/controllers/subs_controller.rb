class SubsController < ApplicationController

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(params.require(:sub).permit(:fecha_inicio, :fecha_fin, :prop_id))
    if params[:sub][:fecha_inicio] > params[:sub][:fecha_fin]
      flash[:alert] = "Error en las fechas"
      redirect_to new_sub_path
    elsif @sub.save
      redirect_to subs_path
    else
      flash[:alert] = "Error al guardar"
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
