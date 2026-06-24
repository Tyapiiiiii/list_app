class TemplatesController < ApplicationController
  # ログインしていないユーザーは、ログイン画面に強制リダイレクトする（Deviseの機能）
  before_action :authenticate_user!
  # 重複するデータ取得を共通化
  before_action :set_template, only: [:show, :edit, :update, :destroy]

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

  def show
    # 詳細画面を開いた瞬間、このテンプレート内のすべての持ち物のチェックを外す（初期化）
    @template.items.update_all(is_checked: false)
  end

  def edit
    # もし持ち物の入力欄が足りなければ、空の入力欄を1つ足しておく（任意）
    @template.items.build if @template.items.blank?
  end

  def update
    if @template.update(template_params)
      redirect_to template_path(@template), notice: 'テンプレートを更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @template.destroy
    redirect_to root_path, notice: 'テンプレートを削除しました。', status: :see_other
  end

  private

  def set_template
    @template = current_user.templates.find(params[:id])
  end

  def template_params
    params.require(:template).permit(:title, :icon_class, :memo, items_attributes: [:id, :name, :_destroy])
  end
end