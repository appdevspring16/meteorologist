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

    url1="https://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}&sensor=false"

    raw_data1 = open(url1).read

    require 'json'

    parsed_data1 = JSON.parse(raw_data1)

    latitude = parsed_data1["results"][0]["geometry"]["location"]["lat"]

    longitude = parsed_data1["results"][0]["geometry"]["location"]["lng"]

    url2="https://api.forecast.io/forecast/34684b2b68fc3cc7a434a8629c2c9c53/#{latitude},#{longitude}"

    raw_data2 = open(url2).read

    parsed_data2 = JSON.parse(raw_data2)

    current_temperature = parsed_data2["currently"]["temperature"]

    current_summary = parsed_data2["currently"]["summary"]

    summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    summary_of_next_several_days = parsed_data2["daily"]["summary"]


    @current_temperature = current_temperature

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    @summary_of_next_several_hours = summary_of_next_several_hours

    @summary_of_next_several_days = summary_of_next_several_days

    render("street_to_weather.html.erb")
  end
end
