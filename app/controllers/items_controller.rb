class ItemsController < ApplicationController
  before_action :authenticate_user!

  def toggle_check
    @item = Item.find(params[:id])
    # 現在のチェック状態を反転させて保存
    @item.update(is_checked: !@item.is_checked)

    # Turboを使って、チェックを入れた部分だけを画面更新する
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to template_path(@item.template) }
    end
  end

  def move
    # ログインユーザーが所有するテンプレートのアイテムであることを確認しつつ取得
    @item = current_user.templates.flat_map(&:items).find { |i| i.id == params[:id].to_i }

    if @item
      # acts_as_listのメソッドを使って、指定された位置に移動
      # JavaScriptからは 0から始まるインデックスが届くので +1 
      @item.insert_at(params[:position].to_i + 1)
      head :no_content
    else
      head :not_found
    end
  end
end