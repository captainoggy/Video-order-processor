class SessionsController < ApplicationController
  skip_before_action :set_current_client, raise: false

  def switch_to_client
    session[:user_type] = :client
    session[:user_id] = Client.first&.id
    redirect_to root_path, notice: "Logged in as Client."
  end

  def switch_to_pm
    session[:user_type] = :pm
    session[:user_id] = Pm.first&.id
    redirect_to notifications_path, notice: "Logged in as PM."
  end
end
