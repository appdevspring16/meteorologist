require 'open-uri'

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
require 'open-uri'
url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)

#results is an array
results = parsed_data["results"]

#first is a hash
first = results[0]

#geometry is a hash
geometry = first["geometry"]

#location is a hash
location = geometry["location"]

lat = location["lat"]

lng = location["lng"]

    @latitude = lat.to_s

    @longitude = lng.to_s

    render("street_to_coords.html.erb")
  end
end
