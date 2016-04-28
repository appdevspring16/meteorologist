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

    url_w = "https://api.forecast.io/forecast/e24c67f6c83c4a165313db53f7c36df0/"+@lat+","+@lng
    parsed_weather_data = JSON.parse(open(url_w).read)

    @current_temperature = parsed_weather_data["currently"]["temperature"]

    @current_summary = parsed_weather_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weather_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
