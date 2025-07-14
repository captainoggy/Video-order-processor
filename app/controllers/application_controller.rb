class ApplicationController < ActionController::Base
  before_action :set_current_client

  private

  def set_current_client
    # Simulate a logged-in client
    @current_client = Client.first
  end
end
