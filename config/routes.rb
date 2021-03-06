Rails.application.routes.draw do

  devise_for :admins, controllers: {
  	registrations: 'admins/registrations'
  }

  devise_for :usuarios, controllers: {
  	sessions: 'usuarios/sessions',
  	registrations: 'usuarios/registrations'
  }

  resources :usuarios
  resources :reservas, :except => [:new]
  resources :props
  resources :subs
  resources :solivips
  resources :pujas, except: :new
  resources :hot_sales
  resources :carousels

  # Pagina que dice prohibido y nada mas
  get "prohibido", to: 'main#prohibido', as: 'prohibido'

  # Ruta, se hace asi para que pase el parametro de la propiedad
  get '/reservar/:prop_id', to: 'reservas#new', as: 'new_reserva'

  # Ruta para reservar una propiedad en Hot Sale
  post 'hot_sales/reservar/:id', to: 'hot_sales#reservar', as: 'reservar_hot_sale'

  get 'mi_cuenta', to: 'usuarios#show', as: 'mi_cuenta'

  get 'aceptar', to: 'solivips#aceptar', as: 'aceptar'

  get 'rechazar', to: 'solivips#rechazar', as: 'rechazar'

  get 'enprogre', to: 'solivips#enprogre', as: 'enprogre'

  get '/pujas/pujar/:id', to: 'pujas#new', as: "pujar"

  # Vista del administrador para obtener las tarjetas
  get 'tarjetas', to: 'main#tarjetas', as: "lista_tarjetas"

  get 'principal', to: 'main#index', as: "principal"

  root 'main#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
