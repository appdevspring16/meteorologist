require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    raw_data = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}").read

    parsed_data = JSON.parse(raw_data)

    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    raw_data_weather = open("https://api.forecast.io/forecast/a007598d1c15f52ce4040ea0c1098ad4/#{@lat},#{@lng}").read

    parsed_data_weather = JSON.parse(raw_data_weather)

    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
