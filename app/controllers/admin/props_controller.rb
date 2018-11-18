class Admin::PropsController < ApplicationController

  def new
    @prop = Prop.new
  end

  def create

    @prop = Prop.new(
      params.require(:prop).permit(:nombre, :ubicacion, :oculto, :hotsale)
      )

    @prop.imgprincipal.attach(params[:prop][:imgprincipal])

    if params[:prop][:images]
      @prop.images.attach(params[:prop][:images])
    end

    if @prop.save
      redirect_to @prop
    else
      flash[:alert] = @prop.errors.full_messages.to_sentence
      redirect_to new_prop_path
    end
  end

  def edit
    @prop = Prop.find(params[:id])
  end

  def index

  @props = Prop.order(hotsale: :desc)

  end

  def update
    @prop=Prop.find(params[:id]);
    if Prop.find(params[:id]).update(params.require(:prop).permit(:nombre, :ubicacion, :oculto, :hotsale))
      if params[:prop][:imgprincipal]
        @prop.imgprincipal.attach(params[:prop][:imgprincipal])
      end
      if params[:destruir]
          @prop.images.purge
      end
      if params[:prop][:images]
        @prop.images.attach(params[:prop][:images])
      end
      redirect_to prop_path
    else
      render :edit
    end
  end
  
end
