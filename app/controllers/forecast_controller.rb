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
    url = "https://api.forecast.io/forecast/c4d162e77805b73b59aba058ea7c4b67/"+ @lat + "," + @lng

    parsed_data = JSON.parse(open(url).read)

    #c4d162e77805b73b59aba058ea7c4b67
    #https://api.forecast.io/forecast/APIKEY/LATITUDE,LONGITUDE

    @current_temperature = parsed_data["currently"]["temperature"]
    #   @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
