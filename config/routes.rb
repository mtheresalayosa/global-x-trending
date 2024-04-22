Rails.application.routes.draw do
  get 'trends/twitter_search'
  get 'trends/global_trends'
  get 'trends/search_location/:src_woeid' => 'trends#search_location'
  get 'trends/trends_updates'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
