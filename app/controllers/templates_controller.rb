class TemplatesController < ApplicationController
  # ログインしていないユーザーは、ログイン画面に強制リダイレクトする（Deviseの機能）
  before_action :authenticate_user!
  # 重複するデータ取得を共通化
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  def index
    # 自分が作成したテンプレと、承認済みの共同編集テンプレを両方取得する
    @templates = Template.where(user_id: current_user.id)
                         .or(Template.where(id: current_user.shared_templates.pluck(:id)))
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
    # 閲覧や編集の権限も、「自分が作ったもの」か「承認済み共同編集のもの」だけにする
    @template = Template.where(user_id: current_user.id)
                        .or(Template.where(id: current_user.shared_templates.pluck(:id)))
                        .find(params[:id])
  end

  def template_params
   params.require(:template).permit(
      :title, 
      :memo, 
      items_attributes: [:id, :name, :position, :_destroy]
    )
  end
end