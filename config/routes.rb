Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  # resources generate an id, in this case user's id
  resources :users, controller: "users", only: [:create, :edit, :update] do

  	# resource doesn't generate an id (password is just a column, not a table)
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  # page with sign up form             #new is the method used
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  	# leads to views => welcome => index
	root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
