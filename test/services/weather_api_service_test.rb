require 'test_helper'

class WeatherApiServiceTest < ActiveSupport::TestCase
  test 'no query returns nil' do
    service = WeatherApiService.new(nil, nil)
    assert_nil service.call
  end

  test 'no units returns nil' do
    service = WeatherApiService.new(nil, nil)
    assert_nil service.call
  end

  test 'invalid units returns nil' do
    service = WeatherApiService.new("Saskatoon", "abc")
    assert_nil service.call
  end

  test 'valid latitude and longitude returns location' do
    service = WeatherApiService.new("Saskatoon", "metric")
    result = service.call
    assert_not_nil result
  end
end