Rails.application.routes.draw do
  devise_for :users

  post '/guest_login', to: 'users/guest_sessions#create'

  # templates のルーティング（index, new, create に加えて show も追加）
  resources :templates

  # 持ち物（アイテム）のルート（チェック切り替えと並び替えを1つに）
  resources :items, only: [] do
    member do
      patch :toggle_check
      patch :move
    end
  end

  root to: "templates#index"
end
