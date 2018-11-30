class PropsController < ApplicationController

  def new
    if admin_signed_in?
      @prop = Prop.new
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end

  def create
 

    @prop = Prop.new(
      params.require(:prop).permit(:nombre, :ubicacion, :oculto)
      )

    if params[:prop][:images].present?
      @prop.images.attach(params[:prop][:images])
    end
    
    if !params[:prop][:imgprincipal].present?
      flash[:alert] = t("props.new.no_imgprincipal")
      redirect_to new_prop_path
    elsif @prop.save
      @prop.imgprincipal.attach(params[:prop][:imgprincipal])
      redirect_to @prop
    else
      flash[:alert] = @prop.errors.full_messages.to_sentence
      redirect_to new_prop_path
    end
  end

  def edit
    if admin_signed_in?
      @prop = Prop.find(params[:id])
    else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
    end
  end

  def update
    @prop=Prop.find(params[:id]);
    if Prop.find(params[:id]).update(params.require(:prop).permit(:nombre, :ubicacion, :oculto))
      
      # Si hay una imagen principal nueva, la carga
      if params[:prop][:imgprincipal].present?
        @prop.imgprincipal.attach(params[:prop][:imgprincipal])
      end

      if params[:destruir]
          @prop.images.purge
      end
      if params[:prop][:images]
        @prop.images.attach(params[:prop][:images])
      end
      redirect_to prop_path
    else
      render :edit
    end
  end

  def show
    @prop = Prop.find(params[:id])
  end

  def index
    if admin_signed_in? || usuario_signed_in?

      # Carga las propiedades a mostrar, si se pasaron opciones de busqueda filtra, si no devuelve todo
      @props = params[:busq] ? Prop.includes(:hot_sale).order('hot_sales.fecha_hotsale ASC, nombre').where('(ubicacion LIKE ?) OR (nombre LIKE ?)', "%#{params[:busq]}%", "%#{params[:busq]}%") : Prop.includes(:hot_sale).order('hot_sales.fecha_hotsale ASC, nombre').all

      # Archivo donde guarda temporalmente las propiedades que tiene que eliminar
      remove = []

    
      # Si no soy admin y la propiedad esta oculta, no la tengo en cuenta
      @props.each do |p|
          if not admin_signed_in?
            if p.oculto
              remove << p
            end
          end
      end

      # Si se enviaron los parametros de fecha
      if (params[:desde] && params[:hasta]) && (params[:desde] != "" && params[:hasta] != "")
        # Convierte el parametro que llego como string a tipo Date
        desde = Date.parse(params[:desde])
        hasta = Date.parse(params[:hasta])

        # Fuerza las fechas a que sean domingo y sabado
        desde = desde - desde.wday
        hasta = hasta + 7
        hasta = hasta - hasta.wday - 1

        # Calcula la cantidad de semanas en el intervalo
        diff = ((hasta - desde + 1).to_i / 7 )

        # Si las fechas tienen coherencia (desde es anterior a hasta, y el intervalo no es mayor a 2 meses)
        if (desde < hasta)
          if ( ( diff ) <= 8)

            # Recorre todas las propiedades para filtrar las que tienen semanas libres
            @props.each do |p|

              # Si la cantidad de reservas es igual a la cantidad de semanas en el
              # intervalo, significa que no hay semanas libres 
              if (p.reserva.where(" (fecha >= ?) AND ( fecha < ?) ", desde, hasta ).count >= diff)
                remove << p
              end

            end

            # Actualiza los parametros para que la fecha a mostrar sea la fecha corregida.
            # Para la semana de inicio se indica el domingo de la primer semana
            params[:desde] = desde
            # Para la ultima semana se indica el sabado que se deberia dejar la propiedad
            params[:hasta] = hasta 

            flash.now[:notice] = t('.cant_semanas') + "#{diff}"
          else
            flash.now[:alert] = t('.error_intervalo')
          end
        else
          # Avisa que las semanas no tienen sentido
          flash.now[:alert] = t('props.search.date_error');
        end
      end
      # Elimina las reservas 
      @props = @props - remove
    end
  else
      flash[:alert] = t('forbidden')
      redirect_to prohibido_path
  end
end

