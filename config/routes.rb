Rails.application.routes.draw do
  devise_for :users
	# root 'users#new'

  resources :users do
  	
  	resources :photos, :only => [:new, :create]
  end

 
  resources :dashboard, only: [:show]
  resources :projects, only: [:show]


  get 'projects/:id/project_page' => 'projects#project_page'

  # get 'index' => 'application#index'
  root 'application#index'
  
end