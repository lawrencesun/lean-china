StartupDigest::Application.routes.draw do
	
	get  	'/signup', to: 'users#new'
	get		'/signin', to: 'sessions#new'
	post 	'/signin', to: 'sessions#create'
	get '/signout', to: 'sessions#destroy'

	resources :users

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end


  root to: 'posts#index'
end
