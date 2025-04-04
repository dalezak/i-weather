require "test_helper"

class ForecastControllerTest < ActionDispatch::IntegrationTest
  test "should get forecasts index" do
    get forecasts_url
    assert_response :success
  end

  test "should post lookup for location" do
    post lookup_forecasts_url, params: { location: "Saskatoon" }
    assert_response :success
  end

  test "should post lookup for latitude and longitude" do
    post lookup_forecasts_url, params: { latitude: 2.146973, longitude: -106.647034 }
    assert_response :success
  end
end
