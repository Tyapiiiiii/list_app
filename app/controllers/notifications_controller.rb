class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending_invitations = current_user.template_relations
                                       .where(status: :pending)
                                       .includes(template: :user)
  end
end
