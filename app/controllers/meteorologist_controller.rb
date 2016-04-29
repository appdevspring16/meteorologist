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

    url="http://maps.googleapis.com/maps/api/geocode/json?address="+"#{url_safe_street_address}/"
    raw_data=open(url).read
    parsed_data = JSON.parse(raw_data)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    urlW="https://api.forecast.io/forecast/3b774a2329641dd76ae113d8e104bde7/"+"#{latitude}"+","+"#{longitude}"
    raw_dataW=open(urlW).read
    parsed_dataW = JSON.parse(raw_dataW)
    current_temperature = parsed_dataW["currently"]["temperature"]
    current_summary = parsed_dataW["currently"]["summary"]
    summary_of_next_sixty_minutes = parsed_dataW["minutely"]["summary"]
    summary_of_next_several_hours = parsed_dataW["hourly"]["summary"]
    summary_of_next_several_days = parsed_dataW["daily"]["summary"]


    @current_temperature = current_temperature

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    @summary_of_next_several_hours = summary_of_next_several_hours

    @summary_of_next_several_days = summary_of_next_several_days

    render("street_to_weather.html.erb")
  end
end
