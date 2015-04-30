class ForecastController < ApplicationController
  def coords_to_weather_form
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    render("coords_to_weather.html.erb")
  end
end
