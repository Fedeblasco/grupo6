class PropsController < ApplicationController

  def new
    @prop = Prop.new
  end

  def create
    @prop = Prop.create(
      params.requiere(:prop).permit(:nombre, :ubicacion)
      )

    if @prop.save
      redirect_to @prop
    else
      redirect_to :new
    end
  end

  def show
    @prop = Porp.find(param(:id))
  end
  
  def index
    @props = Prop.all
  end
end
