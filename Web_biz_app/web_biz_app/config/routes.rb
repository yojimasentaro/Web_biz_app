Rails.application.routes.draw do
  devise_for :users
  root 'photos#index'
  resources  :users, only: [:show, :edit, :update, :index]
  resources  :tags, param: :name,  only: [:index, :show]
  resources  :photos do
    resources :likes,    only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  scope module: :photos do
    resources :popular, only: :index
  end
end
