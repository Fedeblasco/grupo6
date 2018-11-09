class UsuariosController < ApplicationController
  
  def index
  	@usuarios = Usuario.all
  end

  def new
  end

  def show
  	@usuario = Usuario.find(params[:id])
  end
end
