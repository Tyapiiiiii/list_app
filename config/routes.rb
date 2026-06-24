Rails.application.routes.draw do
  devise_for :users

  post '/guest_login', to: 'users/guest_sessions#create'

  # トップページへのアクセスを templates コントローラーの index アクションに向ける
  root to: "templates#index"

  resources :templates
end
