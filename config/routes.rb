Rails.application.routes.draw do
  resources :users do
    resource :addresses
  end

  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
