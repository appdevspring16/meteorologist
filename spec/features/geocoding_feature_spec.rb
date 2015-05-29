require 'rails_helper'

RSpec.describe 'Forecast feature', type: :feature do

  describe "GET /street_to_coords/new" do
    before do
      visit "/street_to_coords/new"
      fill_in "Street Address", with: @address
      click_button "Lookup Coordinates"
    end

    context 'Main Exercise' do
      it "displays the street address", points: 0 do
        expect(page).to have_content(/#{Regexp.quote(@address)}|#{Regexp.quote(@address.gsub('+', ' '))}/i)
      end

      it "displays the latitude", points: 5 do
        expect(page).to have_content '38.89'
      end

      it "displays the longitude", points: 5 do
        expect(page).to have_content '-77.03'
      end
    end
  end
end
