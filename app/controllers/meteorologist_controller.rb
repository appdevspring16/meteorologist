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

    user_loc = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    parsed_loc = JSON.parse(open(user_loc).read)

    @latitude = parsed_loc["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_loc["results"][0]["geometry"]["location"]["lng"]

    user_weather = "https://api.forecast.io/forecast/f8464d2eead9dbb9801c6e0302bf7df8/#{@latitude},#{@longitude}"

    parsed_loc2 = JSON.parse(open(user_weather).read)

    @current_temperature = parsed_loc["currently"]["temperature"]

    @current_summary = parsed_loc["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_loc["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_loc["hourly"]["summary"]

    @summary_of_next_several_days = parsed_loc["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
