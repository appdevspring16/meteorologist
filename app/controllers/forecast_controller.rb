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

  url_weather = "https://api.forecast.io/forecast/99d2772da2b9b8a20e13f1fbad2406c6/" + @lat + "," + @lng + "#"
  
  open(url_weather)

  weather_data = open(url_weather).read

 require 'JSON'

  parsed_weather_data = JSON.parse(open(url_weather).read)
  
  current_temperature = parsed_weather_data["currently"]["temperature"]

  current_summary = parsed_weather_data["currently"]["summary"]

  summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

  summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

  summary_of_next_several_days = parsed_weather_data["daily"]["summary"]


    @current_temperature = current_temperature

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    @summary_of_next_several_hours = summary_of_next_several_hours

    @summary_of_next_several_days = summary_of_next_several_days

    render("coords_to_weather.html.erb")
  end
end
