require 'rails_helper'

RSpec.describe 'Forecast feature', type: :feature do

  describe "GET /street_to_weather/new" do
    before do
      visit "/street_to_weather/new"
      fill_in "Street Address", with: @address
      click_button "Tell me the weather!"
    end

    context 'Main Exercise' do
      it "displays the street address", points: 0 do
        expect(page).to have_content(/#{@address}|#{@address.gsub('+', ' ')}/i)
      end

      it "displays the current temperature", points: 5 do
        temp = '46'
        expect(page).to have_content(temp)
      end

      it "displays the current summary", points: 5 do
        outlook = 'Partly Cloudy'
        expect(page).to have_content(/#{outlook}/i)
      end

      it "displays the outlook for the next sixty minutes", points: 5 do
        outlook = 'Partly cloudy for the hour'
        expect(page).to have_content(/#{outlook}/i)
      end

      it "displays the outlook for the next several hours", points: 5 do
        outlook = 'Mostly cloudy throughout the day'
        expect(page).to have_content(/#{outlook}/i)
      end

      it "displays the outlook for the next several days", points: 5 do
        outlook = 'Light rain tomorrow through Saturday, with temperatures peaking at 69°F on Thursday'
        expect(page).to have_content(/#{outlook}/i)
      end
    end
  end
end
