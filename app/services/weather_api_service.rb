class WeatherApiService < ApplicationService
  include HTTParty
  base_uri 'api.weatherapi.com/v1'
  format :json

  def initialize(query, unit)
    @options = { query: { key: key, aqi: "no", q: query } }
    @unit = unit
  end

  def call
    response = self.class.get("/v1/current.json", @options)
    if response.success?
      WeatherApiParser.parse(response.parsed_response.with_indifferent_access, @unit)
    else
      nil
    end
  end

  private

  def key
    Rails.application.credentials.weather_api_key
  end

end