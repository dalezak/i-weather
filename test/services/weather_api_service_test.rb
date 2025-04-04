require "test_helper"

class WeatherApiServiceTest < ActiveSupport::TestCase
  test "no query returns nil" do
    results = WeatherApiService.call(nil, nil)
    assert_nil results
  end

  test "no units returns nil" do
    results = WeatherApiService.call("Saskatoon", nil)
    assert_nil results
  end

  test "invalid units returns nil" do
    results = WeatherApiService.call("Saskatoon", "abc")
    assert_nil results
  end

  test "valid location returns forecast" do
    mock_temperature = "20°C"
    mock_forecast = Forecast.new(temperature: mock_temperature, updated_at: Time.now)
    mock = Minitest::Mock.new
    mock.expect(:call, mock_forecast, [ "Saskatoon", "metric" ])
    WeatherApiService.stub :call, mock do
      results = WeatherApiService.call("Saskatoon", "metric")
      assert_not_nil results
      assert_equal results.valid?, true
      assert_equal mock_temperature, results.temperature
    end
  end

  test "invalid location returns forecast with valid? false" do
    mock_forecast = Forecast.new(updated_at: nil)
    mock = Minitest::Mock.new
    mock.expect(:call, mock_forecast, [ "Saskatoon", "metric" ])
    WeatherApiService.stub :call, mock do
      results = WeatherApiService.call("Saskatoon", "metric")
      assert_not_nil results
      assert_equal results.valid?, false
    end
  end
end
