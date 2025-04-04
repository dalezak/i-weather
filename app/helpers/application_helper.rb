module ApplicationHelper

  def units
    cookies[:units] || Rails.configuration.x.default_units
  end

  def metric?
    units == Rails.configuration.x.units[:metric][:name]
  end

  def metric_label
    Rails.configuration.x.units[:metric][:label]
  end
  
  def imperial?
    units == Rails.configuration.x.units[:imperial][:name]
  end

  def imperial_label
    Rails.configuration.x.units[:imperial][:label]
  end

  def flash_class(level)
    case level.to_sym
    when :notice
      return "info"
    when :alert
      return "danger"
    when :success
      return "success"
    else
      "secondary"
    end
  end

  def active_for_path(path)
    "active" if params[:action] == path
  end

  def field_value(label, value)
    if value.blank?
      "n/a"
    elsif ['Updated', 'Cached'].include?(label)
      time_ago_in_words(value) + " ago"
    else
      value
    end
  end

end
