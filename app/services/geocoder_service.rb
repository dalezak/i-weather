# frozen_string_literal: true

# This class is responsible for fetching city and state information based on latitude and longitude
class GeocoderService < ApplicationService
  attr_reader :latitude, :longitude

  # Initialize with latitude and longitude
  # @param [Float] latitude
  # @param [Float] longitude
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  # Fetch the city and state from the geocode API
  # @return [String, nil] Returns a string with the city and state or nil if the latitude or longitude is nil
  # @example
  #   GeocoderService.new(40.7128, -74.0060).call
  #   # => "New York, NY"
  #
  #   GeocoderService.new(nil, nil).call
  #   # => nil
  #
  #   GeocoderService.new(34.0522, -118.2437).call
  #   # => "Los Angeles, CA"
  def call
    return nil if latitude.nil?
    return nil if longitude.nil?

    Rails.cache.fetch(cache_key, expires_in: expires_in) do
      geocode = Geocoder.search([ latitude, longitude ]).first
      if geocode.present? && geocode.city.present? && geocode.state.present?
        [ geocode.city, geocode.state ].join(", ")
      else
        nil
      end
    end
  end

  private

  # Fetch the cache expiration time from Rails configuration
  # @return [Integer] The cache expiration time in seconds
  def expires_in
    Rails.application.config.x.cache_expires_in || 30.minutes
  end

  def cache_key
    [ "geocoder", latitude, longitude ].join("/")
  end
end
