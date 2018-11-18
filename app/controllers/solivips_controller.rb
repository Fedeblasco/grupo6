class SolivipsController < ApplicationController

  def new
    @solivip = Solivip.new
  end

  def create
  end

  def edit
  end

  def show
  end

  def index
    @solivips = Solivip.all
  end

  def update
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
end