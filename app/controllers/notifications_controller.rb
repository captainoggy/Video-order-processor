class NotificationsController < ApplicationController
  before_action :require_pm!

  def index
    @notifications = @current_pm.notifications.order(created_at: :desc)
  end

  private

  def require_pm!
    redirect_to root_path, alert: "You must be a PM to view this page." unless @current_user.is_a?(Pm)
  end
end
