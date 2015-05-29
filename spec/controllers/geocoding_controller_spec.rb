require 'rails_helper'

RSpec.describe GeocodingController, type: :controller do
  describe "GET #street_to_coords" do
    it "responds successfully", points: 0 do
      get :street_to_coords, { user_street_address: @address }
      expect(response).to be_success
    end
  end
end
