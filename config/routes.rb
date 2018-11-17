Rails.application.routes.draw do

  # routes regular users
  resources :usuarios
  resources :reservas
  resources :props
  resources :subs
  resources :pujas, except: :new
  resources :dashboard

  get '/pujas/pujar/:id', to: 'pujas#new', as: "pujar"

  root 'props#index'

  # routes for admin users
  namespace :admin do
    resources :props

    root 'props#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
