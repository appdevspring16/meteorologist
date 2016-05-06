require 'open-uri'
require 'json'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]   #this is what the user inputs for address
    url_safe_street_address = URI.encode(@street_address)




    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    user_loc = "https://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"



    open(user_loc)


    parsed_loc = JSON.parse(open(user_loc).read)

    @latitude = parsed_loc["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_loc["results"][0]["geometry"]["location"]["lng"]

    render("street_to_coords.html.erb")
  end
end
