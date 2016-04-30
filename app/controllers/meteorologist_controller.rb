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
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
    raw_data=open(url).read
    require 'json'
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]
    first = results[0]
    geometry = first["geometry"]
    location = geometry["location"]
    latitude = location["lat"]
    longitude = location["lng"]

    url2 = "https://api.forecast.io/forecast/e7237f9fb1c835eff1939a3eb01470f4/#{latitude},#{longitude}"
    raw_data=open(url2).read
    require 'json'
    parsed_data2 = JSON.parse(raw_data)
    currently = parsed_data2["currently"]
    minutely = parsed_data2["minutely"]
    hourly = parsed_data2["hourly"]
    daily = parsed_data2["daily"]

    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================


    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]


    render("street_to_weather.html.erb")
  end
end
