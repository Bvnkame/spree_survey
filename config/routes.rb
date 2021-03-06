Spree::Core::Engine.routes.draw do
  # Add your extension routes here
    namespace :api do
  	resources :foods
  	resources :users do
      resources :foods, controller: 'user_foods'
      resources :surveys, controller: 'user_surveys'
    end
  end

  get '/api/enter_customer_info', to: 'api/surveys#show'
  post '/api/enter_customer_info', to: 'api/surveys#create'
  put '/api/enter_customer_info', to: 'api/surveys#update'

end
