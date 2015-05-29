require 'rails_helper'

RSpec.describe ForecastController, type: :controller do
  describe "GET #coords_to_weather" do
    it "responds successfully", points: 0 do
      get :coords_to_weather, { user_latitude: @lat, user_longitude: @lng }
      expect(response).to be_success
    end
  end
end
