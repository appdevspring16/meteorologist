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
    completed_url = "https://maps.googleapis.com/maps/api/geocode/json?&address=#{url_safe_street_address}"
    parsed_data = JSON.parse(open(completed_url).read)

        @latitude =parsed_data["results"][0]["geometry"]["location"]["lat"]

        @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]


        current_time = Time.current.to_i

        parsed_data_current = JSON.parse(open("https://api.forecast.io/forecast/490fb662acbfe54e362a09de357d59ac/#{@latitude},#{@longitude}").read)

        parsed_data_hour = JSON.parse(open("https://api.forecast.io/forecast/490fb662acbfe54e362a09de357d59ac/#{@latitude},#{@longitude},#{current_time+3600}").read)

        parsed_data_14 = JSON.parse(open("https://api.forecast.io/forecast/490fb662acbfe54e362a09de357d59ac/#{@latitude},#{@longitude},#{current_time+1209600}").read)


            @current_temperature = parsed_data_current["currently"]["temperature"]

            @current_summary = parsed_data_current["currently"]["summary"]

            @summary_of_next_sixty_minutes = parsed_data_hour["currently"]["summary"]

            @summary_of_next_several_hours = parsed_data_current["hourly"]["summary"]

            @summary_of_next_several_days = parsed_data_current["daily"]["summary"]

            @summary_of_next_14_days = parsed_data_14["currently"]["summary"]



    render("street_to_weather.html.erb")
  end
end
