Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get 'up' => 'rails/health#show', as: :rails_health_check
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create index]
      resources :votes, only: [:create]
      post '/login', to: 'sessions#create'
      get '/candidates/:id/vote_count', to: 'candidates#vote_count'
      get '/candidates/vote_counts', to: 'candidates#vote_counts_all'

      # Defines the root path route ("/")
    end
  end

  root 'home#index'
end
