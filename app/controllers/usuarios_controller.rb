class UsuariosController < ApplicationController
  before_action :authenticate_usuario!, :except => [:show, :index]

  def show
    @usuario = Usuario.find(current_usuario.id)
  end

  def update
    @usuario=Usuario.find(current_usuario.id);
    if Usuario.find(current_usuario.id).update(params.require(:usuario).permit(:email, :password, :tarjeta))
      redirect_to root_path
    else
      render :show
    end
  end

end
