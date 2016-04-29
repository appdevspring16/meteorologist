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
    url="https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
     parsed_data = JSON.parse(open(url).read)



     @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]


     @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    #  @lat = params[:user_latitude]
    #  @lng = params[:user_longitude]
     @lat = @latitude.to_s
     @lng = @longitude.to_s

     url="https://api.forecast.io/forecast/748ac12fbac40cfe0b9847d915225676/"+@lat+","+@lng
     parsed_data1 = JSON.parse(open(url).read)



     @current_temperature = parsed_data1["currently"]["temperature"]

     @current_summary = parsed_data1["currently"]["summary"]

     @summary_of_next_sixty_minutes = parsed_data1["minutely"]["summary"]

     @summary_of_next_several_hours = parsed_data1["hourly"]["summary"]

     @summary_of_next_several_days = parsed_data1["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
