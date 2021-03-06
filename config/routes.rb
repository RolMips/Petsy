Rails.application.routes.draw do

  root to: 'users#new'

  get '/profil', to: 'users#edit', as: :profil
  patch '/profil', to: 'users#update'
  get '/users', to: 'users#new'

  resources :users, only: [:new, :create] do
    member do
      get 'confirm'
    end
  end

  #Pets
  resources :pets

  #passwords
  resources :passwords, only: [:new, :create, :edit, :update]

  #sessions
  get '/login', to: 'sessions#new', as: :new_session
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :destroy_session

end
