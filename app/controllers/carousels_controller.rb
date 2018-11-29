class CarouselsController < ApplicationController
  def new
    if Carousel.count == 0
      @carousel=Carousel.new
    else
      flash[:alert] = "Ya hay un carousel creado, edite el existente"
      redirect_to edit_carousel_path(1)
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
    else
      flash[:alert] = @carousel.errors.full_messages.to_sentence
      redirect_to new_carousel_path
    end
  end

  def edit
    @carousel=Carousel.first
  end
end