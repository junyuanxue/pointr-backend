require 'rails_helper'
require 'bigdecimal'

describe 'waypoints API' do
  let!(:journey) { FactoryGirl.create(:journey) }
  let!(:waypoint_1) { FactoryGirl.build(:waypoint, journey: journey) }
  let!(:waypoint_2) { FactoryGirl.build(:waypoint, journey: journey) }

  before do
    request_headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }

    post "/journeys/#{journey.id}/waypoints",
         set_waypoint_params(waypoint_1.latitude, waypoint_1.longitude),
         request_headers

    post "/journeys/#{journey.id}/waypoints",
         set_waypoint_params(waypoint_2.latitude, waypoint_2.longitude),
         request_headers
  end

  describe 'POST /journeys/:journey_id/waypoints' do
    it 'creates a waypoint' do
      expect(response.status).to eq 201
      expect(Waypoint.last.latitude).to eq waypoint_2.latitude
      expect(Waypoint.last.longitude).to eq waypoint_2.longitude
      expect(Waypoint.last.journey_id).to eq journey.id
    end
  end

  describe 'GET /journeys/:journey_id/waypoints' do
    it 'return all the waypoints of a single journey' do
      get "/journeys/#{journey.id}/waypoints", {}, { 'Accept': 'application/json' }
      expect(response.status).to eq 200

      journey_data = JSON.parse(response.body)
      waypoint_1_lat = BigDecimal.new(journey_data[0]["latitude"])
      expect(waypoint_1_lat).to eq waypoint_1.latitude

      waypoint_2_long = BigDecimal.new(journey_data[1]["longitude"])
      expect(waypoint_2_long).to eq waypoint_2.longitude
    end
  end

  describe 'DELETE /waypoints/:id' do
    it 'deletes a waypoint' do
      waypoint = journey.waypoints.last
      delete "/waypoints/#{waypoint.id}"

      expect(response.status).to eq 200
      expect(journey.waypoints).not_to include waypoint
    end
  end
end
