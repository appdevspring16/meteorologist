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


    url = "https://api.forecast.io/forecast/a5f7ff611d14a7a25800449ec1c627b3/#{@lat},#{@lng}"

    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["hourly"]["summary"]

    @summary_of_next_several_hours = 'This hour: ' + parsed_data["hourly"]["data"][0]["summary"] + '; ' +  'Next hour: ' + parsed_data["hourly"]["data"][1]["summary"] + '; ' + 'Two hours from now: ' + parsed_data["hourly"]["data"][2]["summary"] + '; ' + 'Three hours from now: ' + parsed_data["hourly"]["data"][3]["summary"]

    @summary_of_next_several_days = 'Today: ' + parsed_data["daily"]["data"][0]["summary"] + ';  Tomorrow: ' + parsed_data["daily"]["data"][1]["summary"] + '; Two days from now: ' + parsed_data["daily"]["data"][2]["summary"] + '; Three days from now: ' + parsed_data["daily"]["data"][3]["summary"]

    render("coords_to_weather.html.erb")
  end
end
