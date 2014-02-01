StartupDigest::Application.routes.draw do
	
	get  	'/signup', to: 'users#new'
	get		'/signin', to: 'sessions#new'
	post 	'/signin', to: 'sessions#create'
	delete '/signout', to: 'sessions#delete'

	resources :users

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end


  root to: 'posts#index'
end
