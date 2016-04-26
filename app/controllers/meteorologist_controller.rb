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

    url1 = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    open(url1)

    raw_data = open(url1).read

    require "json"

    parsed_data = JSON.parse(raw_data)

    results = parsed_data["results"]

    first = results[0]

    geometry = first["geometry"]

    location = geometry["location"]

      @latitude = location["lat"]

      @longitude = location["lng"]

      url_safe_lat = URI.encode(@latitude.to_s)
      url_safe_lng = URI.encode(@longitude.to_s)



    url2 = "https://api.forecast.io/forecast/81e8d202bef890fe4f834d91201e84be/" + url_safe_lat + "," + url_safe_lng
      open(url2)

      raw_data = open(url2).read

      require "json"

      parsed_data = JSON.parse(raw_data)

      currently = parsed_data["currently"]

      hourly = parsed_data["hourly"]

      minutely = parsed_data["minutely"]

      daily = parsed_data["daily"]

      @current_temperature = currently["temperature"]

      @current_summary = currently["summary"]

      @summary_of_next_sixty_minutes = minutely["summary"]

      @summary_of_next_several_hours = hourly["summary"]

      @summary_of_next_several_days = daily["summary"]

    render("street_to_weather.html.erb")

  end
end
