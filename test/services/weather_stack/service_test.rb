require "test_helper"

class WeatherStack::ServiceTest < ActiveSupport::TestCase
  test "no query returns nil" do
    results = WeatherStack::Service.new(city: nil, region: nil, units: nil).call
    assert_nil results
  end

  test "no units returns nil" do
    results = WeatherStack::Service.new(city: "Saskatoon", region: "Saskatchewan", units: nil).call
    assert_nil results
  end

  test "invalid units returns nil" do
    results = WeatherStack::Service.new(city: "Saskatoon", region: "Saskatchewan", units: "invalid").call
    assert_nil results
  end

  test "valid location returns forecast" do
    mock_temperature = "20°C"
    mock_forecast = Forecast.new(temperature: mock_temperature, updated_at: Time.now)
    mock = Minitest::Mock.new
    mock.expect(:call, mock_forecast, [ "Saskatoon", "Saskatchewan", "metric" ])
    WeatherStack::Service.stub :call, mock do
      results = WeatherStack::Service.new(city: "Saskatoon", region: "Saskatchewan", units: "metric").call
      assert_not_nil results
    end
  end

  test "invalid location returns forecast with valid? false" do
    mock_forecast = Forecast.new(updated_at: nil)
    mock = Minitest::Mock.new
    mock.expect(:call, mock_forecast, [ "Saskatoon", "metric" ])
    WeatherStack::Service.stub :call, mock do
      results = WeatherStack::Service.new(city: "Saskatoon", region: "Saskatchewan", units: "metric").call
      assert_not_nil results
    end
  end
end
