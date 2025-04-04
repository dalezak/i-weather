require "test_helper"

class ForecastTest < ActiveSupport::TestCase
  test "valid? is false" do
    forecast = Forecast.new
    assert_not forecast.valid?
  end

  test "valid? is true" do
    forecast = Forecast.new(updated_at: Time.now)
    assert forecast.valid?
  end
end
