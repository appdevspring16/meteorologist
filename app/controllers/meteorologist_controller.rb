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

    google_url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    gparsed_data = JSON.parse(open(google_url).read)

    @lat = gparsed_data["results"][0]["geometry"]["location"]["lat"]

    @lng = gparsed_data["results"][0]["geometry"]["location"]["lng"]

    latstring = @lat.to_s

    lngstring = @lng.to_s

    forecast_url = "https://api.forecast.io/forecast/cff955fcac3960b0001be689671fd1e9/" + latstring + "," + lngstring
    fparsed_data = JSON.parse(open(forecast_url).read)

    @current_temperature = fparsed_data["currently"]["temperature"]

    @current_summary = fparsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = fparsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = fparsed_data["hourly"]["summary"]

    @summary_of_next_several_days = fparsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
