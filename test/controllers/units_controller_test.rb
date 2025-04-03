require "test_helper"

class UnitsControllerTest < ActionDispatch::IntegrationTest
  test "should get metric" do
    get units_metric_url
    assert_response :success
  end

  test "should get imperial" do
    get units_imperial_url
    assert_response :success
  end
end
