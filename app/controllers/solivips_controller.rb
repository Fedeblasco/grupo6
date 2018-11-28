class SolivipsController < ApplicationController

  def new
    if usuario_signed_in?
      @solivip = Solivip.new
      @solivip.estado = "En progreso"
      @solivip.usuario_id = current_usuario.id
      @solivip.save
      flash[:notice] = "Solicitud creada correctamente"
      redirect_to solivips_path
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end
  end

  def index
    if usuario_signed_in?
      if current_usuario.solivip != nil
        @solivips = Solivip.where(usuario_id: current_usuario.id) 
      else
        redirect_to new_solivip_path
      end
    elsif admin_signed_in?
      @solivips = Solivip.all
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end
  end

  def aceptar
    if admin_signed_in?
      s=Solivip.find(params[:solivip])
      s.estado = "Aceptada"
      u = s.usuario
      u.vip = true
      s.save
      u.save
      redirect_to solivips_path
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end
  end

  def rechazar
    if admin_signed_in?
      s=Solivip.find(params[:solivip])
      s.estado = "Rechazada"
      u = s.usuario
      u.vip = false
      s.save
      u.save
      redirect_to solivips_path
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end
  end  

  def enprogre
    if admin_signed_in?
      s=Solivip.find(params[:solivip])
      s.estado = "En progreso"
      s.save
      redirect_to solivips_path
    else
      flash[:alert] = "Usted no tiene permiso para ver esta seccion"
      redirect_to prohibido_path
    end
  end  
end