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

  test "valid location returns results" do
    mock = Minitest::Mock.new
    mock.expect(:call, { condition: "Sunny" }, [])
    WeatherStack::Service.stub :call, mock do
      results = WeatherStack::Service.new(city: "Saskatoon", region: "Saskatchewan", units: "metric").call
      assert_not_empty results
      assert_not_nil results[:condition]
    end
  end
end
