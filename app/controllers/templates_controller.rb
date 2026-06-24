class TemplatesController < ApplicationController
  # ログインしていないユーザーは、ログイン画面に強制リダイレクトする（Deviseの機能）
  before_action :authenticate_user!

  def index
    # ログインしているユーザーが作ったテンプレートだけを一覧表示する
    @templates = current_user.templates
  end

  def new
    # 空のテンプレートオブジェクトを作る
    @template = current_user.templates.build
    # 最初から持ち物の入力欄を3つ分だけ空で用意しておく
    3.times { @template.items.build }
  end

  def create
    @template = current_user.templates.build(template_params)
    if @template.save
      redirect_to root_path, notice: 'テンプレートを作成しました！'
    else
      # 保存に失敗したら、入力欄を3つ分確保し直して新規作成画面を再表示
      3.times { @template.items.build } if @template.items.blank?
      render :new, status: :unprocessable_entity
    end
  end

  private

  def template_params
    # ストロングパラメーターの設定
    # items_attributes: [:id, :name, :_destroy] を含めることで、持ち物のデータも許可します
    params.require(:template).permit(:title, :icon_class, :memo, items_attributes: [:id, :name, :_destroy])
  end
end