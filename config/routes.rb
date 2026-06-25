Rails.application.routes.draw do
  devise_for :users

  post '/guest_login', to: 'users/guest_sessions#create'

  # templates のルーティング（index, new, create に加えて show も追加）
  resources :templates do
    resources :template_relations, only: [:create]
    member do
      post :reset
    end
  end

  # 承認と削除はテンプレートの外側で自分のIDをもとに動かす
  resources :template_relations, only: [:update, :destroy]

  # 持ち物（アイテム）のルート（チェック切り替えと並び替えを1つに）
  resources :items, only: [] do
    member do
      patch :toggle_check
      patch :move
    end
  end

  resources :notifications, only: [:index]

  root to: "templates#index"
end
