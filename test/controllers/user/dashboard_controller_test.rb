require 'test_helper'

class User::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_dashboard_show_url
    assert_response :success
  end

end
