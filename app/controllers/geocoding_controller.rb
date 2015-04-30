class GeocodingController < ApplicationController
  def street_to_coords_form
    render("street_to_coords_form.html.erb")
  end

  def street_to_coords
    render("street_to_coords.html.erb")
  end
end
