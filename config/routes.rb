Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'about'=>'homes#about'
  resources :foods do
    resource :likes, only: [:create, :destroy]
    resources :lists, except: [:show]
  end
  resources :users, only: [:show, :edit, :update]
  resources :stocks
  resources :categories, except: [:show, :new]
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
end
