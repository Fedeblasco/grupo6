class UsuariosController < ApplicationController
  
  def index
  	@usuarios = Usuario.all
  end

  def show
    
    if admin_signed_in?
    	@usuario = Usuario.find(params[:id])
      @subastas = [ ]

      # Recorre todas las subastas donde el usuario hizo puja, viendo si es el ganador es el
      @usuario.puja.each do |p|
        if p.sub.puja.order('valor desc').first.usuario == @usuario
          if ! @subastas.include? p.sub
            @subastas << p.sub
          end
        end
      end
    elsif usuario_signed_in?
      @usuario = current_usuario
      @subastas = [ ]

      # Recorre todas las subastas donde el usuario hizo puja, viendo si es el ganador es el
      @usuario.puja.each do |p|
        if p.sub.puja.order('valor desc').first.usuario == @usuario
          if ! @subastas.include? p.sub
            @subastas << p.sub
          end
        end
      end
    else
      flash[:alert] = "Usted no tiene acceso a esta seccion"
      redirect_to root_path
    end
  end

end
