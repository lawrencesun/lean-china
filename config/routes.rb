StartupDigest::Application.routes.draw do
	
	get  	'/signup', to: 'users#new'
	get		'/signin', to: 'sessions#new'
	post 	'/signin', to: 'sessions#create'
	get '/signout', to: 'sessions#destroy'

  get '/about', to: 'static_pages#about'
  get '/tools', to: 'static_pages#tools'

	get '/search', to: 'search#index'

	resources :users

  resources :posts do
  	member do 
  		post 'like'
  	end
    resources :comments, only: [:create, :edit, :update, :destroy] do
    	member do
    		post 'like'
    	end
    end
  end

  resources :categories


  root to: 'posts#index'
end
