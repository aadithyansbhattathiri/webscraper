Rails.application.routes.draw do
  namespace :api, constraints: { format: 'json' } do
    resources :products do
      post :create, on: :collection
      get :categories, on: :collection
    end
  end
end
