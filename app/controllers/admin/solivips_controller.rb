class Admin::SolivipsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @solivip = Solivip.new
    @solivip.estado = "En progreso"
    @solivip.usuario_id = current_usuario.id
    @solivip.save
    flash[:notice] = "Solicitud creada correctamente"
    redirect_to solivips_path
  end

  def index
    @solivips = Solivip.all
  end

  def aceptar
    s=Solivip.find(params[:solivip])
    s.estado = "Aceptada"
    u = s.usuario
    u.vip = true
    s.save
    u.save
    redirect_to solivips_path
  end

  def rechazar
    s=Solivip.find(params[:solivip])
    s.estado = "Rechazada"
    u = s.usuario
    u.vip = false
    s.save
    u.save
    redirect_to solivips_path
  end

  def enprogre
    s=Solivip.find(params[:solivip])
    s.estado = "En progreso"
    s.save
    redirect_to solivips_path
  end
end
