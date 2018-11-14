class PujasController < ApplicationController

  def new
    @puja = Puja.new(sub_id: params[:id])
  end

  def create
    @puja = Puja.new(params.require(:puja).permit(:valor,:usuario_id,:sub_id))
    if @puja.save
      redirect_to sub_path(@puja.sub_id)
    else
      flash[:alert] = "Error al pujar"
      redirect_to pujar_path(params[:sub_id])
    end
  end

end

