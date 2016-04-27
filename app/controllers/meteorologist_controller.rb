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

    url_address = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}&"


    parsed_data = JSON.parse(open(url_address).read)

    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]

    long = parsed_data["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.forecast.io/forecast/af1bb5f6c95289e86ac5a34c70c46021/#{lat},#{long}"
    parsed_data = JSON.parse(open(weather_url).read)


    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["daily"]["data"][0]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
