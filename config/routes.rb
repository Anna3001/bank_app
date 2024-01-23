Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }
  resources :transfers

  
  get 'get_email' => 'home#get_email'  
  get 'my_account' => 'home#my_account'  
  root "home#index"
end
