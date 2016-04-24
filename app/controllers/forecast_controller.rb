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

current_time = Time.current.to_i

parsed_data_current = JSON.parse(open("https://api.forecast.io/forecast/490fb662acbfe54e362a09de357d59ac/#{@lat},#{@lng}").read)

parsed_data_hour = JSON.parse(open("https://api.forecast.io/forecast/490fb662acbfe54e362a09de357d59ac/#{@lat},#{@lng},#{current_time+3600}").read)


    @current_temperature = parsed_data_current["currently"]["temperature"]

    @current_summary = parsed_data_current["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_hour["currently"]["summary"]

    @summary_of_next_several_hours = parsed_data_current["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_current["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
