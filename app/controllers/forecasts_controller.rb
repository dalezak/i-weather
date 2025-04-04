class ForecastsController < ApplicationController
  before_action :set_location, only: [:index, :lookup]
  before_action :load_forecast, only: [:index, :lookup]

  def index
  end

  def lookup
  end

  private

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

  def load_forecast
    if @location.present?
      @forecast = WeatherApiService.call(@location, current_units)
    else
      @forecast = nil
    end
  end

end
