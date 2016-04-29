require 'open-uri'
require 'json'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address}"

    # read the url to pull in the raw json file
    raw_data = open(url).read
    # convert the json file to ruby hash
    parsed_data = JSON.parse(raw_data)

    # parse the hash to get the location_hash with lat and lng keys
    location_hash = parsed_data["results"][0]["geometry"]["location"]

    @latitude = location_hash["lat"]
    @longitude = location_hash["lng"]

    render("street_to_coords.html.erb")
  end
end
