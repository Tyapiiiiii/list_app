class ItemsController < ApplicationController
  before_action :authenticate_user!

  def toggle_check
    @item = accessible_items.find(params[:id])
    @item.update(is_checked: !@item.is_checked)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to template_path(@item.template) }
    end
  end

  def move
    @item = owned_items.find_by(id: params[:id])

    if @item
      @item.insert_at(params[:position].to_i + 1)
      head :no_content
    else
      head :not_found
    end
  end

  private

  def accessible_items
    owned  = Item.where(template_id: current_user.templates.select(:id))
    shared = Item.where(template_id: current_user.shared_templates.select(:id))
    owned.or(shared)
  end

  def owned_items
    Item.where(template_id: current_user.templates.select(:id))
  end
end