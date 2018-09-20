Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks"}

  devise_scope :user do
  	get 'sign_in', to: 'user_sessions#new', as: :new_user_session
  	delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    get '/calendars/show' => 'calendars#show'
    get '/calendars' => 'calendars#index'
    get '/calendars/month' => 'calendars#index_month'

    get '/events' => 'events#index'
    get '/events/:id' => 'events#show'

    get '/users' => 'users#index'
    get '/users/show' => 'users#show'
  end

  root to: "static#index"
end
