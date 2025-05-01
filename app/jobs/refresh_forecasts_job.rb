class RefreshForecastsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Forecast.find_each do |forecast|
      RefreshForecastJob.perform_later(forecast.id)
    end
  end
end
