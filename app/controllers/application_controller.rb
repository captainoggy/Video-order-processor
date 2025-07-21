class ApplicationController < ActionController::Base
  include Pagy::Backend
  include CurrentUserConcern

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from StandardError, with: :render_internal_server_error

  private

  def render_not_found(exception = nil)
    logger.warn(exception) if exception
    respond_to do |format|
      format.html { render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end

  def render_internal_server_error(exception = nil)
    logger.error(exception) if exception
    respond_to do |format|
      format.html { render file: Rails.root.join('public', '500.html'), status: :internal_server_error, layout: false }
      format.json { render json: { error: 'Internal Server Error' }, status: :internal_server_error }
    end
  end
end
