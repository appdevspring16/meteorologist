require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
    require 'open-uri'
    raw_data = open(url).read
    require 'json'
    parsed_data = JSON.parse(raw_data)
    
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    long = parsed_data["results"][0]["geometry"]["location"]["lng"]

    url2 = "https://api.forecast.io/forecast/a41c676786543af6dca73fc0c1deeda1/#{lat},#{long}"
    require 'open-uri'
    raw_data2 = open(url2).read
    require 'json'
    parsed_data2 = JSON.parse(raw_data2)


    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]
    render("street_to_weather.html.erb")
  end
end
