Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  post '/listings/:id/remove_image/:i_id' => "listings#remove_image", as: "delete_avatar"

  # post '/listings/:id/verify' => "listings#verify", as: "verify_listing"

  resources :listings do
    resource :verify, only: [:create, :update]
  end

  patch "/listings/:id" => "listings#update", as: "update_listing"






  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "/auth/:provider/callback" => "sessions#create_from_omniauth", as:"google_sign_up"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
