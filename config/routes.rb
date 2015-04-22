Spree::Core::Engine.routes.draw do
  # Add your extension routes here
    namespace :api do
  	resources :foods
  	resources :users do
      resources :foods, controller: 'user_foods'
      resources :surveys, controller: 'user_surveys'
    end
  end

  post '/api/enter_customer_info', to: 'api/surveys#create'
end
