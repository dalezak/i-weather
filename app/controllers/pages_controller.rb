class PagesController < ApplicationController
  include ApplicationHelper

  def index
    if params[:location].present?
      @forecast = WeatherApiService.call(params[:location], metric?)
    end
  end

  def about
  end

end
