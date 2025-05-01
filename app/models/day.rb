# This model is used to represent a single day's weather data.
class Day < ApplicationRecord
  belongs_to :forecast, counter_cache: :days_count

  validates :forecast_id, presence: true
  validates :date, presence: true
end
