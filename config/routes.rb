Rails.application.routes.draw do
  get 'sessions/new'
  # get 'users/new'
  # root 'application#hello'
  # get    '/basic_info/:id',  to: "users#basic_info",  as: "basic_info"   #勤怠B：基本情報の修正ページへ遷移
  # post   '/login',   to: 'sessions#create'
  root 'users#home'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
end
