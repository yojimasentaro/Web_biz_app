Rails.application.routes.draw do
  root 'photos#index'

  get  '/photos/index'  =>    'photos#index'
  get  '/photos/new'    =>    'photos#new'
  get  '/photos/show'   =>    'photos#show'
end