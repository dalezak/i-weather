# frozen_string_literal: true

# This class is responsible for fetching weather data from the Weather API
class WeatherApiService < ApplicationService
  include HTTParty
  base_uri "api.weatherapi.com/v1"
  format :json

  attr_accessor :query, :units, :options

  # Initialize with query and unit
  # @param [String] query
  # @param [String] units
  # @return [Forecast]
  def initialize(query, units)
    @query = query
    @units = units
    @options = { query: { key: api_key, aqi: "no", q: query } }
  end

  # Fetch weather data from the API
  # @return [Forecast, nil] Returns a Forecast object or nil if the query is blank or units are invalid
  # @example
  #   WeatherApiService.new("London", "metric").call
  #   # => Returns a Forecast object with the weather data for London in metric units
  #
  # @example
  #   WeatherApiService.new("", "imperial").call
  #   # => Returns nil because the query is blank
  #
  # @example
  #   WeatherApiService.new("New York", "invalid_unit").call
  #   # => Returns nil because the units are invalid
  def call
    return nil if query.blank?
    return nil if units.blank?
    return nil unless %w[metric imperial].include?(units)

    Rails.cache.fetch(cache_key, expires_in: expires_in) do
      response = self.class.get("/v1/current.json", options)
      WeatherApiParser.parse(response.parsed_response.with_indifferent_access, units)
    end
  end

  private

  # Fetch the API key from Rails credentials
  # @return [String] The API key for the weather API
  def api_key
    Rails.application.credentials.weather_api_key
  end

  # Fetch the cache expiration time from Rails configuration
  # @return [Integer] The cache expiration time in seconds
  def expires_in
    Rails.application.config.x.cache_expires_in || 30.minutes
  end

  # Generate a cache key based on the API name, units, and query
  # @return [String] The cache key for the weather API
  def cache_key
    [ "weather_api", units, query.parameterize ].join("/")
  end
end
