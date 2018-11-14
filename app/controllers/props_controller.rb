class PropsController < ApplicationController

  def new
    @prop = Prop.new
  end

  def create
    @prop = Prop.create(
      params.require(:prop).permit(:nombre, :ubicacion, :oculto)
      )

    @prop.imgprincipal.attach(params[:prop][:imgprincipal])

    if params[:prop][:images]
      @prop.images.attach(params[:prop][:images])
    end

    if @prop.save
      redirect_to @prop
    else
      redirect_to :new
    end
  end

  def edit
    @prop = Prop.find(params[:id])
  end

  def show
    @prop = Prop.find(params[:id])
  end

  def index
    
    # Carga las propiedades a mostrar, si se pasaron opciones de busqueda filtra, si no devuelve todo
    @props = params[:busq] ? Prop.where('(ubicacion LIKE ?) OR (nombre LIKE ?)', "%#{params[:busq]}%", "%#{params[:busq]}%") : Prop.all

    # Si se enviaron los parametros de fecha
    if (params[:desde] && params[:hasta]) && (params[:desde] != "" && params[:hasta] != "")

      # Convierte el parametro que llego como string a tipo Date
      desde = Date.parse(params[:desde])
      hasta = Date.parse(params[:hasta])

      # Si las fechas tienen coherente (desde es anterior a hasta)
      if desde < hasta

        # Fuerza las fechas a que sean domingo
        desde = desde - desde.wday
        hasta = hasta + 7
        hasta = hasta - hasta.wday

        # Calcula la cantidad de semanas en el intervalo
        diff = ((hasta - desde) / 7 ).to_i
        
        # Archivo donde guarda temporalmente las propiedades que tiene que eliminar
        remove = []

        # Recorre todas las propiedades para filtrar las que tienen semanas libres
        @props.each do |p|

          # Si la cantidad de reservas es igual a la cantidad de semanas en el
          # intervalo, significa que no hay semanas libres 
          if (p.reserva.where(" (fecha >= ?) AND ( fecha < ?) ", desde, hasta ).count >= diff)
            remove << p
          end

        end

        # Elimina las reservas 
        @props = @props - remove

        # Actualiza los parametros para que la fecha a mostrar sea la fecha corregida.
        # Para la semana de inicio se indica el domingo de la primer semana
        params[:desde] = desde
        # Para la ultima semana se indica el sabado que se deberia dejar la propiedad
        params[:hasta] = hasta - 1

        flash.now[:notice] = "Cantidad de semanas a buscar: " + "#{diff}"
      else
        # Avisa que las semanas no tienen sentido
        flash.now[:alert] = t('props.search.date_error');
      end
    end

  end

  def update
    @prop=Prop.find(params[:id]);
    if Prop.find(params[:id]).update(params.require(:prop).permit(:nombre, :ubicacion, :oculto))
      @prop.imgprincipal.attach(params[:prop][:imgprincipal])
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

end
