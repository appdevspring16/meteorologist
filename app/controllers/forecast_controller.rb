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

user_weather = "https://api.forecast.io/forecast/f8464d2eead9dbb9801c6e0302bf7df8/#{@lat},#{@lng}"

open(user_weather)

parsed_loc = JSON.parse(open(user_weather).read)

    @current_temperature = parsed_loc["currently"]["temperature"]

    @current_summary = parsed_loc["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_loc["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_loc["hourly"]["summary"]

    @summary_of_next_several_days = parsed_loc["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
