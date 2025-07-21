module RoleAuthorizationConcern
  extend ActiveSupport::Concern

  private

  def require_pm!
    redirect_to root_path, alert: "You must be a PM to view this page." unless @current_user.is_a?(Pm)
  end

  # Add more role-based methods as needed, e.g. require_client!
end
