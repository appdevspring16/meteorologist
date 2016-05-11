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

    url_address = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    parsed_data_address = JSON.parse(open(url_address).read)

    @latitude = parsed_data_address["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data_address["results"][0]["geometry"]["location"]["lng"]

    url_forecast = "https://api.forecast.io/forecast/a5f7ff611d14a7a25800449ec1c627b3/#{@latitude},#{@longitude}"

    parsed_data_forecast = JSON.parse(open(url_forecast).read)

    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = 'This hour: ' + parsed_data_forecast["hourly"]["data"][0]["summary"] + '; ' +  'Next hour: ' + parsed_data_forecast["hourly"]["data"][1]["summary"] + '; ' + 'Two hours from now: ' + parsed_data_forecast["hourly"]["data"][2]["summary"] +
    '; Three hours from now: ' + parsed_data_forecast["hourly"]["data"][3]["summary"]

    @summary_of_next_several_days = 'Today: ' + parsed_data_forecast["daily"]["data"][0]["summary"] + ';  Tomorrow: ' + parsed_data_forecast["daily"]["data"][1]["summary"] + '; Two days from now: ' + parsed_data_forecast["daily"]["data"][2]["summary"] + '; Three days from now: ' + parsed_data_forecast["daily"]["data"][3]["summary"]

    render("street_to_weather.html.erb")
  end
end
