require 'open-uri'
require 'JSON'

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

    raw_forecast_data = open("https://api.forecast.io/forecast/6db586fa317d71790b61def2233b3d83/" + @lat + ","+ @lng).read

    parsed_forecast_data = JSON.parse(raw_forecast_data)

    @current_temperature = parsed_forecast_data["currently"]["temperature"]

    @current_summary = parsed_forecast_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_forecast_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_forecast_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_forecast_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
