require 'open-uri'
#magicaly downloads the ability unto ruby that translates form inputs into url friendly text
require 'json'
#magically downloads into ruby the ability to parse raw html text from websites into ruby friendly hash arrays
class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)
# URI code to translate the form input into something url friendly
    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

url  = "http://maps.googleapis.com/maps/api/geocode/json?address=#{url_safe_street_address}"
#machine form of the google map output. made to be readable by my program


raw_data = open(url).read
#sets the raw html code from the url as a variable

parsed_data = JSON.parse(raw_data)
#JSON magic code--> transforms the html code into ruby friendly hash arrays

latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
#location of latitutde data from the google api. Key result, 1st array item, key geometry, key location, key lat

longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
#location of latitutde data from the google api. Key result, 1st array item, key geometry, key location, key lng


    @latitude = latitude

    @longitude = longitude

    render("street_to_coords.html.erb")
  end
end
