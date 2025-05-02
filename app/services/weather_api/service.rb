# frozen_string_literal: true

# This class is responsible for fetching weather data from the Weather API
class WeatherApi::Service < ApplicationService
  include HTTParty
  base_uri "api.weatherapi.com/v1"
  format :json

  attr_accessor :city, :region, :units, :days, :options

  # Initialize with city, region and days
  # @param [String] city
  # @param [String] region
  # @param [String] units
  # @param [Integer] days
  def initialize(city:, region:, units:, days: 4)
    @city = city
    @region = region
    @units = units
    @days = days
    @options = { query: { key: api_key, aqi: "no", q: [ city, region ].compact.join(", "), days: days } }
  end

  # Fetch weather data from the API
  # @return [Hash, nil] Returns a Forecast object or nil if the location is blank or units are invalid
  def call
    return nil if city.blank?
    return nil if region.blank?
    return nil if units.blank?
    return nil if [ "metric", "imperial" ].exclude?(units)

    Rails.cache.fetch(cache_key, expires_in: expires_in) do
      response = self.class.get("/v1/forecast.json", options)
      data = response.parsed_response.with_indifferent_access
      WeatherApi::Parser.parse(data, units)
    end
  end

  private

  # The Weather API key from Rails configuration
  # @return [String] The API key for the weather API
  def api_key
    Settings.weather_api_key
  end

  # Fetch the cache expiration time from Rails configuration
  # @return [Integer] The cache expiration time in seconds
  def expires_in
    Settings.cache_expires_in
  end

  # Generate a cache key based on the API name, units, region, city, and days
  # @return [String] The cache key for the weather API
  def cache_key
    get_cache_key("weather_api", units, region, city, days)
  end
end
