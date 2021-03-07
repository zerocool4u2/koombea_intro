Rails.application.routes.draw do
  devise_for :users
  resources :users, except: [:new, :create]
  resources :contacts
  resources :csv_files

  get 'home/index'
  root 'home#index'
end
