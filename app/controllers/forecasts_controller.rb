class ForecastsController < ApplicationController

  before_action :set_location, only: [:index, :lookup]

  def index
  end

  def lookup
    if @location.present?
      @forecast = WeatherApiService.call(@location, current_unit)
    else
      @forecast = nil
    end
  end

  private

  def set_location
    if params[:latitude].present? && params[:longitude].present?
      @location = GeocoderService.new(params[:latitude], params[:longitude]).call
    elsif params[:location].present?
      @location = params[:location]
    end
  end
end
