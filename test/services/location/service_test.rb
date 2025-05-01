require "test_helper"

class GeoLocation::ServiceTest < ActiveSupport::TestCase
  test "no latitude or longitude returns nil" do
    results = GeoLocation::Service.call(nil, nil)
    assert_nil results
  end

  test "invalid latitude and longitude returns nil" do
    results = GeoLocation::Service.call(999, 999)
    assert_nil results
  end

  test "valid latitude and longitude returns location" do
    results = GeoLocation::Service.call(52.146973, -106.647034)
    assert_not_nil results
    assert_match(/Saskatoon, Saskatchewan/, results)
  end
end
