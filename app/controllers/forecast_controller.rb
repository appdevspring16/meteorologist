require 'open-uri'
class ForecastController < ApplicationController
  def coords_to_weather_form
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    url_safe_lat = URI.encode(@lat)
    @lng = params[:user_longitude]
    url_safe_lng = URI.encode(@lng)
    url =   "https://api.forecast.io/forecast/db2825893824d75139310e793ae904eb/#{url_safe_lat},#{url_safe_lng}"
  
    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data["currently"]["temperature"]

    @current_summary = parsed_data["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
