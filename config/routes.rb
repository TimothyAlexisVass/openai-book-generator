Rails.application.routes.draw do
  root to: 'books#index'
  resources :books, only: [:index, :show, :new, :create, :destroy]
  post '/gpt', to: 'gpt#gpt'
end
