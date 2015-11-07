Rails.application.routes.draw do
	root 'users#new'

  resources :users

  get 'index' => 'application#index'
  
end
