require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    require 'open-uri'
    url = "https://api.forecast.io/forecast/5b47037d8ede8f15c6b54ca801e12407/" + @lat + "," + @lng
    raw_data = open(url).read

    
    #parsed_data is a hash
    parsed_data = JSON.parse(raw_data)

    #currently is a hash
    currently = parsed_data["currently"]

    #current_summary is a string
    current_summary = currently["summary"]

    #current_temperature is a float
    current_temperature = currently["temperature"]

    #summary_of_next_sixty_minutes
    minutely = parsed_data["minutely"]
    minute_summary = minutely["summary"]

    #summary_of_next_several_hours
    hourly = parsed_data["hourly"]
    hour_summary = hourly["summary"]

    #summary_of_next_several_days
    daily = parsed_data["daily"]
    day_summary = daily["summary"]

    @current_temperature = current_temperature.to_s

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = minute_summary

    @summary_of_next_several_hours = hour_summary

    @summary_of_next_several_days = day_summary

    render("coords_to_weather.html.erb")
  end
end
