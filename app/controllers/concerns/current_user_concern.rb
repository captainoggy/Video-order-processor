module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  private

  def set_current_user
    if session[:user_type] == "pm"
      @current_pm = Pm.find_by(id: session[:user_id])
      @current_user = @current_pm
    else
      # Default to client
      @current_client = Client.find_by(id: session[:user_id]) || Client.first
      session[:user_type] = :client
      session[:user_id] ||= @current_client.id
      @current_user = @current_client
    end
  end
end
