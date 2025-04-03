class WeatherApiService < ApplicationService
  include HTTParty
  base_uri 'api.weatherapi.com/v1'
  format :json

  def key
    Rails.application.credentials.weather_api_key
  end

  def initialize(query, metric: true)
    @options = { query: { key: key, aqi: "no", q: query } }
  end

  def call
    response = self.class.get("/v1/current.json", @options)
    if response.success?
      response.parsed_response.with_indifferent_access
    else
      nil
    end
  end

end