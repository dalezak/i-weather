# frozen_string_literal: true

# This class is responsible for fetching city and state information based on latitude and longitude
class GeoLocation::Service < ApplicationService
  attr_reader :latitude, :longitude, :query

  # Initialize with latitude and longitude
  # @param [Float] latitude
  # @param [Float] longitude
  # @param [String] query
  def initialize(latitude: nil, longitude: nil, query: nil)
    @latitude = latitude
    @longitude = longitude
    @query = query
  end

  # Fetch the city and state from the geocode API
  # @return [String, nil] Returns a string with the city and state or nil if the latitude or longitude is nil
  def call
    search = query if query.present?
    search ||= [ latitude, longitude ].join(", ")
    return nil if search.blank?

    Rails.cache.fetch(cache_key, expires_in: expires_in) do
      geocode = Geocoder.search(search).first
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
    [ "geo_location", latitude, longitude, query.to_s.parameterize ].compact.join("/")
  end
end
