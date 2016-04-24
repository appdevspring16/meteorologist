require 'open-uri'
require 'json'

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
    geocode_string = "https://maps.googleapis.com/maps/api/geocode/json?address="
    geo_url = geocode_string + url_safe_street_address

    raw_geo_data = open(geo_url).read
    parsed_geo_data = JSON.parse(raw_geo_data)
    geo_results = parsed_geo_data["results"]
    geo_first = geo_results[0]

    lat = geo_first["geometry"]["location"]["lat"]
    lng = geo_first["geometry"]["location"]["lng"]

    ds_api = "https://api.forecast.io/forecast/"
    api_key = "3b8fdec05259d0f35ae3b0fe32d31cc2"
    loc = "/" + lat + "," + lng
    ds_url = ds_loc + api_key + loc

    raw_ds_data = open(ds_url).read
    parsed_ds_data = JSON.parse(raw_ds_data)

    @current_temperature = parsed_ds_data["currently"]["temperature"]

    @current_summary = parsed_ds_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_ds_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_ds_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_ds_data["daily"]["summary"]
    
    render("street_to_weather.html.erb")
  end
end
