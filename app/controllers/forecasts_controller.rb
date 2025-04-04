class ForecastsController < ApplicationController
  before_action :set_location, only: [:index, :lookup]
  before_action :load_forecast, only: [:index, :lookup]

  def index
  end

  def lookup
  end

  private

  # Sets the location based on parameters or cookies.
  # @note This method checks for latitude and longitude parameters, a location parameter, or a location stored in cookies.
  def set_location
    if params[:latitude].present? && params[:longitude].present?
      @location = GeocoderService.new(params[:latitude], params[:longitude]).call
      cookies[:location] = @location
    elsif params[:location].present?
      @location = params[:location]
      cookies[:location] = @location
    elsif cookies[:location].present?
      @location = cookies[:location]
    else
      @location = nil
    end
  end

  # Loads the weather forecast based on the location.
  # @note This method calls the WeatherApiService to fetch the forecast data.
  # @return [void]
  def load_forecast
    if @location.present?
      @forecast = WeatherApiService.call(@location, current_units)
    else
      @forecast = nil
    end
  end

end
