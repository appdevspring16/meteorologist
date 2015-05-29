require 'rails_helper'

RSpec.describe MeteorologistController, type: :controller do
  describe "GET #street_to_weather" do
    it "responds successfully", points: 0 do
      get :street_to_weather, { user_street_address: @address }
      expect(response).to be_success
    end
  end
end
