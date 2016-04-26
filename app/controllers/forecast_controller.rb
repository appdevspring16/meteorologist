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

    full_url="https://api.forecast.io/forecast/1da3577cb79679e9302f35ff12f9b30c/" + @lat + "," + @lng

    parsed_data = JSON.parse(open(full_url).read)

    # parsed_data keys => ["latitude", "longitude", "timezone", "offset", "currently", "minutely", "hourly", "daily", "flags"]


    @current_temperature = parsed_data["currently"]["temperature"].to_s + " F"

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["hourly"]["data"][0]["summary"].to_s + " for the hour."

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
