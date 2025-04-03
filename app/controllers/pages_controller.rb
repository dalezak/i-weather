class PagesController < ApplicationController
  
  def index
    if params[:location].present?
      @forecast = WeatherApiService.call(params[:location], current_unit)
    end
  end

  def about
  end

end
