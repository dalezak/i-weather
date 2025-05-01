# frozen_string_literal: true

# This class represents a weather forecast
class Forecast < ApplicationRecord
  belongs_to :city, counter_cache: :forecasts_count

  has_many :days, dependent: :destroy

  validates :city_id, presence: true

  scope :for_city, ->(city) { joins(:city).where(cities: { name: city }) if city.present? }
  scope :for_region, ->(region) { joins(:city).where(cities: { region: region }) if region.present? }

  def cached_at
    Time.now
  end

  def refresh?
    condition.blank? || updated_at < Settings.forecast_refresh_in.ago
  end

  def refresh!
    Settings.forecast_services.each do |service_name|
      service_class = service_name.camelize.constantize
      service_instance = service_class.new(city.name, city.region, units)
      attributes = service_instance.call
      if attributes.present?
        attributes.each do |key, value|
          if key == :days
            refresh_days(value)
          elsif self.respond_to?(key)
            self[key] = value
          end
        end
        self.save
        break
      end
    end
    self.reload
  end

  private

  def refresh_days(days_data)
    if days_data.present?
      days_data.each do |day_data|
        day = days.find_or_create_by(date: day_data[:date], units: units)
        day.update(day_data)
      end
    else
      days.destroy_all
    end
  end
end
