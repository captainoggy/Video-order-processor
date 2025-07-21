class NotificationsController < ApplicationController
  before_action :require_pm!

  def index
    @notifications = @current_pm.notifications.order(created_at: :desc)
    @notifications = @notifications.by_creation_date_range(params[:start_date], params[:end_date]) if params[:start_date].present? || params[:end_date].present?
    @notifications = @notifications.by_message_keyword(params[:keyword]) if params[:keyword].present?
  end

  def show
    @notification = @current_pm.notifications.find(params[:id])
    unless @notification.read?
      @notification.update(read: true)
    end
  end

  private

  def require_pm!
    redirect_to root_path, alert: "You must be a PM to view this page." unless @current_user.is_a?(Pm)
  end
end
