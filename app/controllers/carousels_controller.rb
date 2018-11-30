class CarouselsController < ApplicationController
  def new
    if admin_signed_in?
      if Carousel.count == 0
        @carousel=Carousel.new
      else
        flash[:alert] = "Ya hay un carousel creado, edite el existente"
        redirect_to edit_carousel_path(1)
      end
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end   
  end

  def create
    @carousel = Carousel.new(
      params.require(:carousel).permit(:texto1fto1, :texto2fto1, 
        :texto1fto2, :texto2fto2, 
        :texto1fto3, :texto2fto3)
      )

    if !(params[:carousel][:imageA].present? && params[:carousel][:imageB].present? && params[:carousel][:imageC].present?)
      flash[:alert] = "Falto agregar alguna de las imagenes"
      redirect_to new_carousel_path
    elsif @carousel.save
      @carousel.imageA.attach(params[:carousel][:imageA])
      @carousel.imageB.attach(params[:carousel][:imageB])
      @carousel.imageC.attach(params[:carousel][:imageC])
      flash[:notice] = "Carousel creado correctamente"
      redirect_to root_path
    else
      flash[:alert] = @carousel.errors.full_messages.to_sentence
      redirect_to new_carousel_path
    end
  end

  def edit   
    if admin_signed_in?
      @carousel=Carousel.first
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end
  end

  def update
    @carousel = Carousel.first
    if Carousel.first.update(
      params.require(:carousel).permit(:texto1fto1, :texto2fto1, 
        :texto1fto2, :texto2fto2, 
        :texto1fto3, :texto2fto3)
      )
      if params[:carousel][:imageA].present?
        @carousel.imageA.attach(params[:carousel][:imageA])
      end
      if params[:carousel][:imageB].present?
        @carousel.imageB.attach(params[:carousel][:imageB])
      end
      if params[:carousel][:imageC].present?
        @carousel.imageC.attach(params[:carousel][:imageC])
      end
      flash[:notice] = "Carousel editado correctamente"
      redirect_to root_path
    else
      render :edit
    end
  end
end