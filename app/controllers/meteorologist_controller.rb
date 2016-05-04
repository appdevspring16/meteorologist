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
    require 'open-uri'
    require 'json'

    geo_url = "http://maps.googleapis.com/maps/api/geocode/json?address="+ url_safe_street_address

    geo_data_parsed = JSON.parse(open("geo_url").read)


    @latitude = geo_data_parsed["results"][0]["geometry"]["location"]["lat"].to_s

    @longitude =  geo_data_parsed["results"][0]["geometry"]["location"]["lng"].to_s

    forecast_data_parsed = JSON.parse(open("https://api.forecast.io/forecast/b5041c65a640b3f007e68f68a031f4ed/"+ @lat + @lng).read)



    @current_temperature = forecast_data_parsed["currently"]["temperature"]

    @current_summary = forecast_data_parsed["currently"]["summary"]

    @summary_of_next_sixty_minutes = forecast_data_parsed["minutely"]["summary"]

    @summary_of_next_several_hours = forecast_data_parsed["hourly"]["summary"]

    @summary_of_next_several_days = forecast_data_parsed["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
