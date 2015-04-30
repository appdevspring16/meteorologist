class MeteorologistController < ApplicationController
  def street_to_weather_form
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    render("street_to_weather.html.erb")
  end
end
