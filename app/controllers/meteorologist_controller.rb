require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    url_geo="http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address

    parsed_data_geo = JSON.parse(open(url_geo).read)
    la = parsed_data_geo["results"][0]["geometry"]["location"]["lat"].to_s
    lo = parsed_data_geo["results"][0]["geometry"]["location"]["lng"].to_s
    lat=la.to_s
    lng=lo.to_s

    url="https://api.forecast.io/forecast/1a06af7b604ffa96460a58b38720cfcd/"+la+","+lo
    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
