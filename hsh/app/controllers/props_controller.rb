class PropsController < ApplicationController

  def new
    @prop = Prop.new
  end

  def create
    @prop = Prop.create(
      params.require(:prop).permit(:nombre, :ubicacion)
      )

    if @prop.save
      redirect_to @prop
    else
      redirect_to :new
    end
  end

  def show
    @prop = Prop.find(params[:id])
  end

  def index
    @props = Prop.all
  end
end
