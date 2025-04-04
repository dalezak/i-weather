module ApplicationHelper

  # The user's current units preference for displaying weather data.
  # @note This method checks the cookies for the user's unit preference.
  def units
    cookies[:units] || Rails.configuration.x.default_units
  end

  # Is the current unit metric?
  # @return [Boolean] true if the current unit is metric, false otherwise
  def metric?
    units == Rails.configuration.x.units[:metric][:name]
  end

  # Returns the label for the current unit
  # @return [String] the label for the current unit
  def metric_label
    Rails.configuration.x.units[:metric][:label]
  end
  
  # Is the current unit imperial?
  # @return [Boolean] true if the current unit is imperial, false otherwise
  def imperial?
    units == Rails.configuration.x.units[:imperial][:name]
  end

  # Returns the label for the current unit
  # @return [String] the label for the current unit
  def imperial_label
    Rails.configuration.x.units[:imperial][:label]
  end

  # Returns the label for the current unit
  # @return [String] the label for the current unit
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

  # Returns 'active' class if the current action matches the given path
  # @param path [String] the path to check against the current action
  # @return [String] 'active' if the current action matches the path, nil otherwise
  def active_for_path(path)
    "active" if params[:action] == path
  end

  # Returns the appropriate field value based on the label and value
  # @param label [String] the label of the field
  # @param value [String] the value of the field
  # @return [String] the formatted field value
  # @note If the value is blank, returns "n/a". If the label is 'Updated' or 'Cached', returns a time ago string.
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
