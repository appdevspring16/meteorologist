require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    @url = "https://api.forecast.io/forecast/b6c1de3ea99274d6b236c03443fb318b/"+@lat.to_s+","+@lng.to_s

    @current_temperature = JSON.parse(open(@url).read)["currently"]["temperature"]

    @current_summary = JSON.parse(open(@url).read)["currently"]["summary"]

    @summary_of_next_sixty_minutes = JSON.parse(open(@url).read)["minutely"]["summary"]

    @summary_of_next_several_hours = JSON.parse(open(@url).read)["hourly"]["summary"]

    @summary_of_next_several_days = JSON.parse(open(@url).read)["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
