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

    first_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    parsed_data = JSON.parse(open(first_url).read)

    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    second_url = "https://api.forecast.io/forecast/430522187cf821182d46ce5d92b21b39/#{@latitude},#{@longitude}"

    forecast_data = JSON.parse(open(second_url).read)

    @current_temperature = forecast_data["currently"]["temperature"]

    @current_summary = forecast_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = forecast_data["minutely"]["summary"]

    @summary_of_next_several_hours = forecast_data["hourly"]["summary"]

    @summary_of_next_several_days = forecast_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
