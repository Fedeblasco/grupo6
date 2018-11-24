class Admin::PropsController < ApplicationController
  before_action :check_access

  def check_access
    redirect_to props_url and return unless admin_signed_in?
  end

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
    @props_reservas = Prop.joins(:reserva)
    @props_subastas = Prop.joins(:sub)
    @props_hotsale = Prop.where("hotsale = true")
    @props_oculto = Prop.where("oculto = true")
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
