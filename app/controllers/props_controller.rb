class PropsController < ApplicationController

  def show
    @prop = Prop.find(params[:id])
  end

  def index

    @props = []

    if usuario_signed_in?

    # Carga las propiedades a mostrar, si se pasaron opciones de busqueda filtra, si no devuelve todo
    @props = params[:busq] ? Prop.order(hotsale: :desc).where('(ubicacion LIKE ?) OR (nombre LIKE ?)', "%#{params[:busq]}%", "%#{params[:busq]}%") : Prop.order(hotsale: :desc)

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

      # Si las fechas tienen coherencia (desde es anterior a hasta, y el intervalo no es mayor a 2 meses)
      if (desde < hasta)
        if ((hasta - desde).to_i <= 8)
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
          flash.now[:alert] = "El intervalo es mayor a 8 semanas"
        end
      else
        # Avisa que las semanas no tienen sentido
        flash.now[:alert] = t('props.search.date_error');
      end
    end
    # Elimina las reservas
    @props = @props - remove
    end

  end

end
