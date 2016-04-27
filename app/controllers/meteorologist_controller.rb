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
    url_in_google_format = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
    parsed_data_map = JSON.parse(open(url_in_google_format).read)
    latitude_result = parsed_data_map["results"][0]["geometry"]["location"]["lat"]
    longitude_result = parsed_data_map["results"][0]["geometry"]["location"]["lng"]
    @latitude = latitude_result
    @longitude = longitude_result

    url_in_weather_format ="https://api.forecast.io/forecast/7d8f57f92330e7851249c921bfbbdde7/#{@latitude},#{@longitude}"
    parsed_data_weather = JSON.parse(open(url_in_weather_format).read)

    time_stamp = Time.now.to_i
    @time = time_stamp
    url_time_weather = "https://api.forecast.io/forecast/7d8f57f92330e7851249c921bfbbdde7/#{@latitude},#{@longitude},#{@time}"
    parsed_data_time_weather = JSON.parse(open(url_time_weather).read)

    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_time_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_time_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
