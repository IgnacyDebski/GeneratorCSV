Rails.application.routes.draw do

  root 'home#home'
  delete 'logout', to: 'trello_authorizes#destroy'
  get 'csv', to: 'home#csv_fields'
  post 'csv', to: 'home#csv_fields'

  resources :trello_authorizes do
    collection do
      get :callback
      get :trello_not_logged
    end
  end
end
