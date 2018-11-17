Rails.application.routes.draw do

  devise_for :admins, controllers: {
  	registrations: 'admins/registrations'
  }

  devise_for :usuarios, controllers: {
  	sessions: 'usuarios/sessions',
  	registrations: 'usuarios/registrations'
  }

  resources :usuarios
  resources :reservas
  resources :props
  resources :subs
  resources :pujas, except: :new

  get 'mi_cuenta', to: 'usuarios#show', as: 'mi_cuenta'

  get '/pujas/pujar/:id', to: 'pujas#new', as: "pujar"

  root 'props#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
