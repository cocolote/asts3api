Rails.application.routes.draw do
  resources :aws_profiles do
    resources :buckets
  end
end
