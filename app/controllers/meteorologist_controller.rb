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

  url_street_weather = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

  open(url_street_weather)
  raw_data = open(url_street_weather).read

  require 'JSON'
  

  parsed_data=JSON.parse(open(url_street_weather).read)
  latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
  longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude

    @longitude = longitude

    url_weather = "https://api.forecast.io/forecast/99d2772da2b9b8a20e13f1fbad2406c6/" + @latitude.to_s + "," + @longitude.to_s + "#"

     open(url_weather)

  weather_data = open(url_weather).read

  parsed_weather_data = JSON.parse(open(url_weather).read)
  
  current_temperature = parsed_weather_data["currently"]["temperature"]

  current_summary = parsed_weather_data["currently"]["summary"]

  summary_of_next_sixty_minutes = parsed_weather_data["minutely"]["summary"]

  summary_of_next_several_hours = parsed_weather_data["hourly"]["summary"]

  summary_of_next_several_days = parsed_weather_data["daily"]["summary"]




    @current_temperature = current_temperature

    @current_summary = current_summary

    @summary_of_next_sixty_minutes = summary_of_next_sixty_minutes

    @summary_of_next_several_hours = summary_of_next_several_hours

    @summary_of_next_several_days = summary_of_next_several_days

    render("street_to_weather.html.erb")
  end
end
