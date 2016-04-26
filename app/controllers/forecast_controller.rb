require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]
    url_safe_lat = URI.encode(@lat)
    url_safe_lng = URI.encode(@lng)

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.forecast.io/forecast/81e8d202bef890fe4f834d91201e84be/" + url_safe_lat+ "," + url_safe_lng

    open(url)

    raw_data = open(url).read

    require "json"

    parsed_data = JSON.parse(raw_data)

    currently = parsed_data["currently"]

    first = currently[0]

    hourly = parsed_data["hourly"]

    minutely = parsed_data["minutely"]

    daily = parsed_data["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("coords_to_weather.html.erb")
  end
end
