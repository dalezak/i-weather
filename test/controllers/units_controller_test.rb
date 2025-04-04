require "test_helper"

class UnitsControllerTest < ActionDispatch::IntegrationTest
  test "should set metric" do
    post metric_units_url
    assert_equal cookies[:units], "metric"
    assert_response :redirect
  end

  test "should set imperial" do
    post imperial_units_url
    assert_equal cookies[:units], "imperial"
    assert_response :redirect
  end
end
