class UsuariosController < ApplicationController
  
  def index
  	@usuarios = Usuario.all
  end

  def new
  	@usuario = Usuario.new
  end

  def create

  	@usuario = Usuario.create(params.require(:usuario).permit(:mail))

  	if @usuario.save
  		redirect_to @usuario
  	else
  		render :new
  	end

  end

  def show
  	@usuario = Usuario.find(params[:id])
  end

end
