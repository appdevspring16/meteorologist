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

    url="http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address+"&sensor=false"
    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url2="https://api.forecast.io/forecast/3dba79de7f37f0d288724ed8f23a626c/"+"#{latitude}"","+ "#{longitude}"
    parsed_data_2 = JSON.parse(open(url2).read)



    @current_temperature = parsed_data_2["currently"]["temperature"]

    @current_summary = parsed_data_2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_2["daily"]["summary"]


    render("street_to_weather.html.erb")
  end
end
