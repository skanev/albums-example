Albums::Application.routes.draw do
  devise_for :users

  resources :albums

  if Rails.env.test?
    get '/backdoor/login', to: 'backdoor#login', as: :backdoor_login
  end

  root to: 'home#index'
end
