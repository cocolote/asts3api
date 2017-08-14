Rails.application.routes.draw do
  post '/signup', to: 'user#create'
  post 'auth/login', to: 'authentication#authenticate'

  resources :aws_profiles do
    resources :buckets
  end
end
