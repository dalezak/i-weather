# frozen_string_literal: true

# This class is responsible for fetching city and state information based on latitude and longitude
class GeoLocation::Service < ApplicationService
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
    Settings.cache_expires_in
  end

  def cache_key
    [ "location", latitude, longitude ].join("/")
  end
end
