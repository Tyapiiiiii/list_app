class TemplateRelationsController < ApplicationController
  before_action :authenticate_user!

  # 招待を送るアクション
  def create
    @template = current_user.templates.find(params[:template_id])
    # フォームに入力されたメールアドレスから、招待したいユーザーを探す
    invitee = User.find_by(email: params[:email])

    if invitee.nil?
      redirect_to template_path(@template), alert: "指定されたメールアドレスのユーザーが見つかりません。"
    elsif invitee == current_user
      redirect_to template_path(@template), alert: "自分自身を招待することはできません。"
    else
      # 中間テーブルに status: :pending (デフォルト0) でレコードを作成
      @relation = @template.template_relations.build(user: invitee)
      if @relation.save
        redirect_to template_path(@template), notice: "#{invitee.email} に招待を送りました！"
      else
        redirect_to template_path(@template), alert: "すでに招待済み、または共同編集者です。"
      end
    end
  end

  # 💡 招待を「承認」するアクション
  def update
    # 自分宛ての未承認の招待を探す
    @relation = current_user.template_relations.find(params[:id])
    
    # ステータスを accepted (承認済み) に更新
    if @relation.accepted!
      redirect_to root_path, notice: "招待を承認しました！共同編集ができるようになりました。"
    else
      redirect_to root_path, alert: "承認に失敗しました。"
    end
  end

  # 招待を「拒否」または「解除」するアクション
  def destroy
    @relation = current_user.template_relations.find(params[:id])
    @relation.destroy
    redirect_to root_path, notice: "招待を辞退しました。"
  end
end