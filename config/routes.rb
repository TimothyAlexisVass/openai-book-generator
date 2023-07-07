Rails.application.routes.draw do
  root to: 'books#index'
  resources :books, only: [:index, :show, :new, :create, :destroy] do
  
    resources :chapters, only: [:index] do
      post 'handle', on: :collection
    end

    resources :sections, only: [:index] do
      post 'handle', on: :collection

      resources :paragraphs, only: [:index] do
        post 'handle', on: :collection
      end
    end
  end
  post '/gpt', to: 'gpt#gpt'
end
