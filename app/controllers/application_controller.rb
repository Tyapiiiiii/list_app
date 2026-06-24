class ApplicationController < ActionController::Base
  # Deviseのコントローラーが動く前に、追加のパラメーターを許可する設定を呼び出します
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ（新規登録）の時に name カラムの付与を許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント更新（編集）の時に name カラムの付与を許可する
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end