require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form

    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    url_geocoding = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"

    parsed_data = JSON.parse(open(url_geocoding).read)

    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url_forecast =   "https://api.forecast.io/forecast/db2825893824d75139310e793ae904eb/#{latitude},#{longitude}"


    parsed_data = JSON.parse(open(url_forecast).read)

    @current_temperature = parsed_data["currently"]["temperature"]
    @current_summary = parsed_data["currently"]["summary"]
    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]
    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]
    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
