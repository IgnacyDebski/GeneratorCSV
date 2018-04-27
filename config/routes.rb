Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'csv', to: 'home#csv_fields'
  post 'csv', to: 'home#csv_fields'

  resources :trello_authorizes do
    collection do
      get :callback
      get :trello_not_logged
    end
  end
end
