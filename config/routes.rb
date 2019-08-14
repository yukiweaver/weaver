Rails.application.routes.draw do
  get 'calendars/show'
  # get 'sessions/new'
  # get 'users/new'
  # root 'application#hello'
  # get    '/basic_info/:id',  to: "users#basic_info",  as: "basic_info"   #勤怠B：基本情報の修正ページへ遷移
  # post   '/login',   to: 'sessions#create'
  root 'sessions#new'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/household',  to: 'incomes#new'
  get    '/error',  to: 'errors#error'
  get    '/graph',  to: 'expenses#graph'
  get    '/bar_graph', to: 'expenses#bar_graph'
  get    '/auth/:provider/callback', to: 'sessions#auth_create'
  resources :users
  resources :incomes
  resources :expenses
end
