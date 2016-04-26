require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address
    require 'open-uri'
    raw_data = open(url).read
    require 'json'
    parsed_data = JSON.parse(raw_data)

    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    long = parsed_data["results"][0]["geometry"]["location"]["lng"]


    @latitude = lat

    @longitude = long

    render("street_to_coords.html.erb")
  end
end
