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

  # Ruta, se hace asi para que pase el parametro de la propiedad
  get '/reservar/:prop_id', to: 'reservas#new', as: 'new_reserva'
  get 'mi_cuenta', to: 'usuarios#show', as: 'mi_cuenta'
  get 'aceptar', to: 'solivips#aceptar', as: 'aceptar'
  get 'rechazar', to: 'solivips#rechazar', as: 'rechazar'
  get 'enprogre', to: 'solivips#enprogre', as: 'enprogre'
  get '/pujas/pujar/:id', to: 'pujas#new', as: "pujar"

  root 'main#index'

  # routes for admin users
  namespace :admin do
    resources :props
    resources :reservas
    resources :subs
    resources :usuarios
    resources :solivips

    root 'props#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
