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
    address_data = JSON.parse(open('https://maps.googleapis.com/maps/api/geocode/json?address=' + url_safe_street_address).read)
    @latitude =address_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = address_data["results"][0]["geometry"]["location"]["lng"]

    parsed_data = JSON.parse(open('https://api.forecast.io/forecast/1402a1aad04c24ded871cc2bb18c15d3/' + @latitude.to_s + ',' + @longitude.to_s).read)


    @current_temperature = parsed_data ["currently"]["temperature"]

    @current_summary = parsed_data ["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data ["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data ["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data ["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
