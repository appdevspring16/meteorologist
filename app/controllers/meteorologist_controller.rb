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
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"

    # read the url to pull in the raw json file
    raw_data = open(url).read
    # convert the json file to ruby hash
    parsed_data = JSON.parse(raw_data)

    # parse the hash to get the location_hash with lat and lng keys
    location_hash = parsed_data["results"][0]["geometry"]["location"]

    latitude = location_hash["lat"]
    longitude = location_hash["lng"]

    # SG: url below got from https://developer.forecast.io/
    # Has my unique key
    url = "https://api.forecast.io/forecast/1dc293ea1f302a8739796dead6f06926/#{latitude},#{longitude}"

    # read the url to pull in the raw json file
    raw_data = open(url).read
    # convert the json file to ruby hash
    parsed_data = JSON.parse(raw_data)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
