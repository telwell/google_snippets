Rails.application.routes.draw do
  devise_for :users
	# root 'users#new'

  resources :users do
  	resource :dashboard
  end

  resources :projects

  # get 'index' => 'application#index'
  root 'application#index'
  
end