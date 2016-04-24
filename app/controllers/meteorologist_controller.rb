require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    geocode_url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
    geocode_parsed_data = JSON.parse(open(geocode_url).read)
    lat = geocode_parsed_data["results"][0]["geometry"]["location"]["lat"]
    lng = geocode_parsed_data["results"][0]["geometry"]["location"]["lng"]

    weather_url = "https://api.forecast.io/forecast/b79530e7a9a6b3d55582825db684f3fa/" + lat.to_s + "," + lng.to_s
    weather_parsed_data = JSON.parse(open(weather_url).read)

    @current_temperature = weather_parsed_data["currently"]["temperature"]

    @current_summary = weather_parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = weather_parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = weather_parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = weather_parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
