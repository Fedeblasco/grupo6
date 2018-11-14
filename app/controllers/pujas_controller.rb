class ReservasController < ApplicationController

  def index
  	@pujas = Puja.all
  end

  def new
  	@puja = Puja.new
  end

  def create
  end

end
