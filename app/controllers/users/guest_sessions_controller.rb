class Users::GuestSessionsController < ApplicationController
  def create
    
    user = User.guest
    # Deviseのメソッドを使って、そのユーザーとしてログイン状態にする
    sign_in user
    # トップページへリダイレクト
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました！', status: :see_other
  end
end