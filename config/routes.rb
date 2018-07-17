Rails.application.routes.draw do

  get 'homepage/index'
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create]

  # resources generate an id, in this case user's id
  	# to override users,controller for users is changed from "clearance/users" to "users"
  resources :users, controller: "users", only: [:create, :edit, :update, :show, :index] do
	# get "/users" => "users#index"
	# get "/users/:id" => "users#show"

  	# resource doesn't generate an id (password is just a column, not a table)
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  	# leads to views => welcome => index
	  root 'welcome#index'

  	# page with sign up form             #new is the method used
  	get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  	delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  	get "/sign_up" => "users#new", as: "sign_up"

	# user clicked on form -> google, users will get redirected back
	get "/auth/:provider/callback" => "sessions#create_from_omniauth"

	# homepage
	get "/homepage" => "homepage#index"
  
	# nested routes
	resources :listings do
    resources :reservations
  end
	# replaces:
	# get "/listing" => "listing#index"
	# post "/listing/index" => "listing#create"
	# get "/listing/:id" => "listing#show"
	# get "/listing/:id/edit" => "listing#show#edit"

	patch "/listings/:id/verify" => "listings#verify", as: "verify"

  post "/listings/match" => "listings#match", as: "match"
  post "/listings/search" => "listings#search", as: "search"

  get 'reservations/:id/braintree/new' => 'braintree#new', as: "new_braintree"
  post 'reservations/:id/braintree/checkout' => 'braintree#checkout', as: "checkout_braintree"
  #
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

