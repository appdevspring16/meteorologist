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

    url="http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
    open(url)
    raw_data=open(url).read
    require 'json'
    parsed_data = JSON.parse(open(url).read)
    @metlat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @metlng = parsed_data["results"][0]["geometry"]["location"]["lng"]


    meturl="https://api.forecast.io/forecast/7c57b1de179477fbadd719f4fc899e09/"+@metlat.to_s+","+@metlng.to_s
    open(meturl)
    raw_data=open(meturl).read
    parsed_data = JSON.parse(open(meturl).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
