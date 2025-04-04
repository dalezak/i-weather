class UnitsController < ApplicationController
  
  def metric
    set_metric
    flash[:notice] = "Your units have been set to metric, so you'll see celsius, km/h, etc"
    redirect_to root_path
  end

  def imperial
    set_imperial
    flash[:notice] = "Your units have been set to imperial, so you'll see fahrenheit, mph, etc"
    redirect_to root_path
  end
end
