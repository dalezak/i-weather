class RefreshForecastJob < ApplicationJob
  queue_as :default

  def perform(forecast_id)
    forecast = Forecast.find(forecast_id)
    if forecast.refresh?
      forecast.refresh!
      Rails.logger.info "Forecast for #{forecast.city.name} refreshed at #{forecast.cached_at}"
    else
      Rails.logger.info "Forecast for #{forecast.city.name} is up to date."
    end
  end
end
