class PropsController < ApplicationController

  def new
    @prop = Prop.new
  end

  def create
    @prop = Prop.create(
      params.require(:prop).permit(:nombre, :ubicacion, :oculto)
      )

    @prop.imgprincipal.attach(params[:prop][:imgprincipal])

    if params[:prop][:images]
      @prop.images.attach(params[:prop][:images])
    end

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
    @props =
    if params[:busq]
      Prop.where('(ubicacion LIKE ?) OR (nombre LIKE ?)', "%#{params[:busq]}%", "%#{params[:busq]}%")
    else
      Prop.all
    end
end

  def update
    if Prop.find(params[:id]).update(params.require(:prop).permit(:nombre, :ubicacion, :oculto))
      redirect_to prop_path
    else
      render :edit
    end
  end

end
