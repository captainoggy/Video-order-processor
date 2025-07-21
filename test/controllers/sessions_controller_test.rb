require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get switch_to_client" do
    get sessions_switch_to_client_url
    assert_response :success
  end

  test "should get switch_to_pm" do
    get sessions_switch_to_pm_url
    assert_response :success
  end
end
