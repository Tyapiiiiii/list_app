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
end