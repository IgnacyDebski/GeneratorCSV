Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'registration', to: 'sessions#registration_form'
  post 'registration', to: 'sessions#registration'
  delete 'logout', to: 'sessions#destroy'
end
