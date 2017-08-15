Rails.application.routes.draw do
  post '/signup', to: 'user#create'
  post 'auth/login', to: 'authentication#authenticate'

  resources :aws_profiles do
    resources :buckets, controller: "aws_profile_buckets"
  end

  resources :user, only: [:update, :destroy] do
    resources :buckets, controller: "user_buckets"
  end
end
