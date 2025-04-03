module ApplicationHelper

  def unit
    cookies[:unit] || Rails.configuration.x.default_units
  end

  def metric?
    unit == Rails.configuration.x.units[:metric][:unit]
  end

  def metric_label
    Rails.configuration.x.units[:metric][:label]
  end
  
  def imperial?
    unit == Rails.configuration.x.units[:imperial][:unit]
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

  def time_ago(time)
    return if time.nil?
    return if time.blank?
    time_ago_in_words(time) + " ago"
  end

end
