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

#Part 1
    require 'open-uri'
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    #results is an array
    results = parsed_data["results"]

    #first is a hash
    first = results[0]

    #geometry is a hash
    geometry = first["geometry"]

    #location is a hash
    location = geometry["location"]

    lat = location["lat"]

    lng = location["lng"]


#Part 2
    url = "https://api.forecast.io/forecast/5b47037d8ede8f15c6b54ca801e12407/" + lat.to_s + "," + lng.to_s
    raw_data = open(url).read


    #parsed_data is a hash
    parsed_data = JSON.parse(raw_data)

    #currently is a hash
    currently = parsed_data["currently"]

    #current_summary is a string
    current_summary = currently["summary"]

    #current_temperature is a float
    current_temperature = currently["temperature"]

    #summary_of_next_sixty_minutes
    minutely = parsed_data["minutely"]
    minute_summary = minutely["summary"]

    #summary_of_next_several_hours
    hourly = parsed_data["hourly"]
    hour_summary = hourly["summary"]

    #summary_of_next_several_days
    daily = parsed_data["daily"]
    day_summary = daily["summary"]


    @current_temperature = current_temperature.to_s

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = minute_summary

    @summary_of_next_several_hours = hour_summary

    @summary_of_next_several_days = day_summary

    render("street_to_weather.html.erb")
  end
end
