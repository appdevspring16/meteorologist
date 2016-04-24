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

# Converting address to lat/long so dark sky can read it (using google API)
    url_safe_street_address = URI.encode(@street_address)
    url_safe_full = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
    parsed_data = JSON.parse(open(url_safe_full).read)

    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

# Now I'm using the coords from the google api data and using dark sky API to get weather for the location
    url_for_dark_sky= "https://api.forecast.io/forecast/e308f111cdb2db5d0a337db32f008c75/#{latitude},#{longitude}"
    parsed_data = JSON.parse(open(url_for_dark_sky).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary =
    parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
