Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'projects#index'
  resources :projects

  namespace :api do
    resources :projects, only: [:index, :create]
  end
end
