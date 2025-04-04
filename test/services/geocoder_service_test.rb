require 'test_helper'

class GeocoderServiceTest < ActiveSupport::TestCase
  test 'no latitude or longitude returns nil' do
    service = GeocoderService.new(nil, nil)
    assert_nil service.call
  end

  test 'invalid latitude and longitude returns nil' do
    service = GeocoderService.new(999, 999)
    result = service.call
    assert_nil result
  end

  test 'valid latitude and longitude returns location' do
    service = GeocoderService.new(52.146973, -106.647034)
    result = service.call
    assert_not_nil result
    assert_match(/Saskatoon, Saskatchewan/, result)
  end
end