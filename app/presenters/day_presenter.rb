class DayPresenter < ApplicationPresenter
  attr_reader :day, :units

  def initialize(day)
    @day = day
    @units = day.units || Settings.default_units
  end

  def date
    day.date.to_s
  end

  def icon
    day.icon
  end

  def condition
    day.condition
  end

  def max_temp
    return "n/a" if day.max_temp.blank?

    day.max_temp.to_s + field_symbol(:temperature)
  end

  def min_temp
    return "n/a" if day.min_temp.blank?

    day.min_temp.to_s + field_symbol(:temperature)
  end

  def avg_temp
    return "n/a" if day.avg_temp.blank?

    day.avg_temp.to_s + field_symbol(:temperature)
  end

  def max_wind
    return "n/a" if day.max_wind.blank?

    day.max_wind.to_s + field_symbol(:wind_speed)
  end

  def total_precipitation
    return "n/a" if day.total_precipitation.blank?

    day.total_precipitation.to_s + field_symbol(:precipitation)
  end

  def avg_visibility
    return "n/a" if day.avg_visibility.blank?

    day.avg_visibility.to_s + field_symbol(:visibility)
  end

  def avg_visibility
    return "n/a" if day.avg_visibility.blank?

    day.avg_visibility.to_s + field_symbol(:humidity)
  end
end
