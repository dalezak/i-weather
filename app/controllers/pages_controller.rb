class PagesController < ApplicationController
  
  def index
    if params[:latitude].present? && params[:longitude].present?
      location = GeocoderService.new(params[:latitude], params[:longitude]).call
    elsif params[:location].present?
      location = params[:location]
    end
    if location.present?
      @forecast = WeatherApiService.call(location, current_unit)
    else
      @forecast = nil
    end
  end

  def about
  end

end
