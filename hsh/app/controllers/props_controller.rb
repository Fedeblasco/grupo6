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

  def edit
    @prop = Prop.find(params[:id])
  end

  def show
    @prop = Prop.find(params[:id])
  end

  def index
    @props = Prop.all
  end

  def update
    if Prop.find(params[:id]).update(params.require(:prop).permit(:nombre, :ubicacion))
      redirect_to prop_path
    else
      render :edit
    end
  end

end
