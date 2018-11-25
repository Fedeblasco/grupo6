class UsuariosController < ApplicationController
  before_action :authenticate_usuario!, :except => [:show, :index]

  def show
    @prop = Usuario.find(current_usuario.id)
  end

end
