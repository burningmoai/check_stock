Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root to: "homes#about"
  get 'about'=>'homes#about'
  get 'food_limit'=>'stocks#limit'
  resources :foods do
    resource :likes, only: [:create, :destroy]
  end
  # 食材のソート foodコントローラにsearchアクションを作る
  get 'foods/search/sort_like', to: 'foods#search', as: 'sort_like'
  get 'foods/search/sort_new', to: 'foods#search', as: 'sort_new'
  get 'foods/search/sort_old', to: 'foods#search', as: 'sort_old'
  # 食材のソートここまで
  resources :lists, except: [:show]
  resources :users, only: [:show, :edit, :update]
  resources :stocks
  resources :categories, except: [:show, :new]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
