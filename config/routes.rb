Rails.application.routes.draw do
  devise_for :users

  # トップページへのアクセスを templates コントローラーの index アクションに向ける
  root to: "templates#index"
end
