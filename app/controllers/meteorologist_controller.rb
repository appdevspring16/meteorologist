require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    @url1 = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address

    @latitude = JSON.parse(open(@url1).read)["results"][0]["geometry"]["location"]["lat"]

    @longitude = JSON.parse(open(@url1).read)["results"][0]["geometry"]["location"]["lng"]

    @url = "https://api.forecast.io/forecast/b6c1de3ea99274d6b236c03443fb318b/"+@latitude.to_s+","+@longitude.to_s

    @current_temperature = JSON.parse(open(@url).read)["currently"]["temperature"]

    @current_summary = JSON.parse(open(@url).read)["currently"]["summary"]

    @summary_of_next_sixty_minutes = JSON.parse(open(@url).read)["minutely"]["summary"]

    @summary_of_next_several_hours = JSON.parse(open(@url).read)["hourly"]["summary"]

    @summary_of_next_several_days = JSON.parse(open(@url).read)["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
