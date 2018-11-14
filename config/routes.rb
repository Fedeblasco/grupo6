Rails.application.routes.draw do

  resources :usuarios
  resources :reservas
  resources :props
  resources :subs
  resources :pujas, except: :new

  get '/pujas/pujar/:id', to: 'pujas#new', as: "pujar"

  root 'props#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
