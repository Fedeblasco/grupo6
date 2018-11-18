Rails.application.routes.draw do

  devise_for :admins, controllers: {
  	registrations: 'admins/registrations'
  }

  devise_for :usuarios, controllers: {
  	sessions: 'usuarios/sessions',
  	registrations: 'usuarios/registrations'
  }

  resources :reservas
  resources :props
  resources :subs
  resources :pujas, except: :new

  get 'mi_cuenta', to: 'usuarios#show', as: 'mi_cuenta'

  get '/pujas/pujar/:id', to: 'pujas#new', as: "pujar"

  root 'props#index'

  # routes for admin users
  namespace :admin do
    resources :props
    resources :subs
    resources :usuarios

    root 'props#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
