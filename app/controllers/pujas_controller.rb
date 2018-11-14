class PujasController < ApplicationController

  def new
    @puja = Puja.new
  end

  def index
  	@pujas = Puja.all
  end

  def create
    @puja = Puja.new(params.require(:puja).permit(:valor,:usuario_id,:sub_id))
    if @puja.save
      redirect_to pujas_path
    else
      flash[:alert] = "Error al guardar"
      render :new
    end
  end

end
