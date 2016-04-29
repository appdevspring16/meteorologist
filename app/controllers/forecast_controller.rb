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

url="https://api.forecast.io/forecast/748ac12fbac40cfe0b9847d915225676/"+@lat+","+@lng
parsed_data1 = JSON.parse(open(url).read)


    @current_temperature = parsed_data1["currently"]["temperature"]

    @current_summary = parsed_data1["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data1["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data1["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data1["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
