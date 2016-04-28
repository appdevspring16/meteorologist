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

    url_lookup_map= "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    parsed_data_lookup_map = JSON.parse(open(url_lookup_map).read)
    latitude = parsed_data_lookup_map["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data_lookup_map["results"][0]["geometry"]["location"]["lng"]

    url_lookup_weather = "https://api.forecast.io/forecast/7b618fb49a0913f26ddf3a6b9735e41a/" + latitude.to_s + "," + longitude.to_s
    parsed_data_lookup_weather = JSON.parse(open(url_lookup_weather).read)


    @current_temperature = parsed_data_lookup_weather["currently"]["temperature"]

    @current_summary = parsed_data_lookup_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_lookup_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_lookup_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_lookup_weather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
