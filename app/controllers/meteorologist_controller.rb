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

    raw_data = open("http://maps.googleapis.com/maps/api/geocode/json?address=" +url_safe_street_address).read

    parsed_data = JSON.parse(raw_data)

    results = parsed_data["results"]

    first = results[0]

    geometry = first["geometry"]

    location = geometry["location"]

    latitude = location["lat"]

    longitude = location["lng"]

    raw_forecast_data = open("https://api.forecast.io/forecast/6db586fa317d71790b61def2233b3d83/" + latitude.to_s + ","+ longitude.to_s).read

    parsed_forecast_data = JSON.parse(raw_forecast_data)

    @current_temperature = parsed_forecast_data["currently"]["temperature"]

    @current_summary = parsed_forecast_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_forecast_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_forecast_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_forecast_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
