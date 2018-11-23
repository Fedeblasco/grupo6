class Admin::UsuariosController < ApplicationController
  before_action :check_access

  def check_access
    redirect_to root_url and return unless admin_signed_in?
  end

  def index
  	@usuarios = Usuario.all
  end

  def new
  	@usuario = Usuario.new
  end

  def create

  	@usuario = Usuario.create(params.require(:usuario).permit(:email))

  	if @usuario.save
  		redirect_to [:admin, @usuario]
  	else
  		render :new
  	end

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
