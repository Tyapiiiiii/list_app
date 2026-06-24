Rails.application.routes.draw do
  devise_for :users

  post '/guest_login', to: 'users/guest_sessions#create'

  # templates のルーティング（index, new, create に加えて show も追加）
  resources :templates, only: [:index, :new, :create, :show]

  # items のチェック切り替え用ルート
  resources :items, only: [] do
    member do
      patch :toggle_check
    end
  end

  # トップページへのアクセスを templates コントローラーの index アクションに向ける
  root to: "templates#index"

  resources :templates
end
