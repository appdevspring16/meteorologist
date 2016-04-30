require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)
    @url = "https://maps.googleapis.com/maps/api/geocode/json?address="+url_safe_street_address

    @latitude = JSON.parse(open(@url).read)["results"][0]["geometry"]["location"]["lat"]

    @longitude = JSON.parse(open(@url).read)["results"][0]["geometry"]["location"]["lng"]

    render("street_to_coords.html.erb")
  end
end
