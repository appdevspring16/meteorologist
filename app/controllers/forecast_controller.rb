require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    @lat = @lat.gsub(" ", "")
    @lng = @lng.gsub(" ", "")

    # SG: url below got from https://developer.forecast.io/
    # Has my unique key
    url = "https://api.forecast.io/forecast/1dc293ea1f302a8739796dead6f06926/#{@lat},#{@lng}"

    # read the url to pull in the raw json file
    raw_data = open(url).read
    # convert the json file to ruby hash
    parsed_data = JSON.parse(raw_data)




    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================



    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
