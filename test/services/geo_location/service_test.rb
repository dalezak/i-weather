require "test_helper"

class GeoLocation::ServiceTest < ActiveSupport::TestCase
  test "no latitude or longitude returns nil" do
    results = GeoLocation::Service.new(latitude: nil, longitude: nil).call
    assert_nil results
  end

  test "invalid latitude and longitude returns nil" do
    results = GeoLocation::Service.new(latitude: 999, longitude: 999).call
    assert_nil results
  end

  test "valid latitude and longitude returns location" do
    results = GeoLocation::Service.new(latitude: 52.146973, longitude: -106.647034).call
    assert_not_nil results
    assert_match(/Saskatoon, Saskatchewan/, results)
  end

  test "valid query returns location" do
    results = GeoLocation::Service.new(query: "Saskatoon").call
    assert_not_nil results
    assert_match(/Saskatoon, Saskatchewan/, results)
  end
end
