Rails.application.routes.draw do
  resources :users do
    resource :addresses
  end
end
