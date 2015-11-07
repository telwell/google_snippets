Rails.application.routes.draw do
  devise_for :users
	# root 'users#new'

  resources :users do
  	resource :dashboard
  end

  get 'projects/:id/project_page' => 'projects#project_page'

  # get 'index' => 'application#index'
  root 'application#index'
  
end