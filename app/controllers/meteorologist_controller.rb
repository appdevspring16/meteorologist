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

    addurl="http://maps.googleapis.com/maps/api/geocode/json?address="+ url_safe_street_address
    open(addurl)
    raw_add_data = open(addurl).read
    require 'json'
    parsed_add_data = JSON.parse(raw_add_data)
    lat = parsed_add_data["results"][0]["geometry"]["location"]["lat"].to_s
    lng = parsed_add_data["results"][0]["geometry"]["location"]["lng"].to_s

    weathurl="https://api.forecast.io/forecast/823f920c0b1d3d139f9bba3e1657f6e2/"+lat+","+lng
    open(weathurl)
    raw_weath_data = open(weathurl).read
    require 'json'
    parsed_weath_data = JSON.parse(raw_weath_data)

    @current_temperature = parsed_weath_data["currently"]["temperature"]

    @current_summary = parsed_weath_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_weath_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_weath_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_weath_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
