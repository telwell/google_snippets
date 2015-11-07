Rails.application.routes.draw do
  devise_for :users
	root 'users#new'

  resources :users

  get 'index' => 'application#index'
  
end
