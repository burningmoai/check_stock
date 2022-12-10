Rails.application.routes.draw do
  devise_for :users
  root to: "stocks#index"
  get 'about'=>'homes#about'
  get 'food_limit'=>'stocks#limit'
  resources :foods do
    resource :likes, only: [:create, :destroy]
  end
  resources :lists, except: [:show]
  resources :users, only: [:show, :edit, :update]
  resources :stocks
  resources :categories, except: [:show, :new]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
