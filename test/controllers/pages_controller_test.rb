require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home page" do
    get pages_url
    assert_response :success
    assert_select "#forecast_results", "Loading..."
  end

  test "should get about page" do
    get about_pages_url
    assert_response :success
  end

  test "should post forecast for location" do
    post forecast_pages_url, params: { location: "Saskatoon, Saskatchewan" }
    assert_response :success
  end

  test "should post forecast for latitude and longitude" do
    post forecast_pages_url, params: { latitude: 2.146973, longitude: -106.647034 }
    assert_response :success
  end

  test "should set metric" do
    post metric_pages_url
    assert_equal cookies[:units], "metric"
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  test "should set imperial" do
    post imperial_pages_url
    assert_equal cookies[:units], "imperial"
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end

  test "missing page should redirect to root" do
    get "/nonexistent_page"
    assert_redirected_to root_url
    follow_redirect!
    assert_response :success
  end
end
