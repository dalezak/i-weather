require "test_helper"

class WeatherApiParserTest < ActiveSupport::TestCase
  test "no response returns empty forecast" do
    forecast = WeatherApiParser.parse(nil, nil)
    assert_nil forecast.updated_at
    assert_equal forecast.valid?, false
  end

  test "no units returns empty forecast" do
    forecast = WeatherApiParser.parse({ current: { updated_at: Time.now.to_s } }, nil)
    assert_nil forecast.updated_at
    assert_equal forecast.valid?, false
  end

  test "invalid units returns empty forecast" do
    forecast = WeatherApiParser.parse({ current: { updated_at: Time.now.to_s } }, "abc")
    assert_nil forecast.updated_at
    assert_equal forecast.valid?, false
  end

  test "valid response returns forecast" do
    updated_at = Time.now.to_s
    forecast = WeatherApiParser.parse({ current: { last_updated: updated_at } }, "metric")
    assert_equal forecast.updated_at, updated_at
    assert_equal forecast.valid?, true
  end

  test "has correct symbol for metric units" do
    forecast = WeatherApiParser.parse({ current: { last_updated: Time.now.to_s, temp_c: 20 } }, "metric")
    assert_equal "20°C", forecast.temperature
  end

  test "has correct symbol for imperial units" do
    forecast = WeatherApiParser.parse({ current: { last_updated: Time.now.to_s, temp_f: 68 } }, "imperial")
    assert_equal "68°F", forecast.temperature
  end
end
