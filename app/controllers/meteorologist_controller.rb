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

    google_map_data = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}&sensor=false").read
    require 'json'
    parsed_google_map = JSON.parse(google_map_data)
    google_map_results = parsed_google_map["results"]
    google_map_first = google_map_results[0]
    google_map_geometry = google_map_first["geometry"]
    google_map_location = google_map_geometry["location"]
      latitude = google_map_location["lat"]
      longitude = google_map_location["lng"]

    forecast_data = open("https://api.forecast.io/forecast/e44ac8fc846c2f9b48152197c6d94a7f/#{latitude},#{longitude}").read
    require = 'json'
    parsed_forecast = JSON.parse(forecast_data)

      currently = parsed_forecast["currently"]
      minutely = parsed_forecast["minutely"]
      hourly = parsed_forecast["hourly"]
      daily = parsed_forecast["daily"]

      @current_temperature = currently["temperature"]

      @current_summary = currently["summary"]

      @summary_of_next_sixty_minutes = minutely["summary"]

      @summary_of_next_several_hours = hourly["summary"]

      @summary_of_next_several_days = daily["summary"]

    render("street_to_weather.html.erb")
  end
end
