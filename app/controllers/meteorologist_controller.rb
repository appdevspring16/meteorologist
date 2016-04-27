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

    full_url_geo="http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    parsed_data = JSON.parse(open(full_url_geo).read)
    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

    full_url_fcst="https://api.forecast.io/forecast/1da3577cb79679e9302f35ff12f9b30c/" + @lat + "," + @lng
    parsed_data = JSON.parse(open(full_url_fcst).read)


    @current_temperature = parsed_data["currently"]["temperature"].to_s + " F"

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["hourly"]["data"][0]["summary"].to_s + " for the hour."

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
