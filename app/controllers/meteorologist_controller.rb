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

    @url1 = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    @parsed_data1 = JSON.parse(open(@url1).read)
    @latitude = @parsed_data1["results"][0]["geometry"]["location"]["lat"]
    @longitude = @parsed_data1["results"][0]["geometry"]["location"]["lng"]
    @lat = @latitude.to_s
    @lng = @longitude.to_s
    url_lat_lng = @lat + "," + @lng
    @url = "https://api.forecast.io/forecast/89941ac599de9219989802563cbd5e2a/" + url_lat_lng

    @parsed_data = JSON.parse(open(@url).read)

    @current_temperature = @parsed_data["currently"]["temperature"]

    @current_summary = @parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = @parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = @parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = @parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
