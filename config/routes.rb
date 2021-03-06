Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}
	# root 'users#new'

  resources :users do
  	
  	resources :photos, :only => [:new, :create]
  end

  
  resources :dashboard, only: [:show]
  resources :projects, only: [:show, :create]
  resources :snippets, only: [:create]
  resources :subscriptions, only: [:create, :destroy]


  get 'projects/:id/project_page' => 'projects#project_page'

  # get 'index' => 'application#index'
  root 'application#index'
  
end