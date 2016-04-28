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

    url_lookup = "https://api.forecast.io/forecast/7b618fb49a0913f26ddf3a6b9735e41a/" + @lat + "," + @lng
    parsed_data_lookup = JSON.parse(open(url_lookup).read)

    @current_temperature = parsed_data_lookup["currently"]["temperature"]

    @current_summary = parsed_data_lookup["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_lookup["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_lookup["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_lookup["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
