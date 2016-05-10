require 'rails_helper'
require 'bigdecimal'

describe 'waypoints API' do
  let!(:journey) { FactoryGirl.create(:journey) }
  let!(:waypoint_1) { FactoryGirl.build(:waypoint, journey: journey) }
  let!(:waypoint_2) { FactoryGirl.build(:waypoint, journey: journey) }
  let!(:request_headers) { { 'Accept': 'application/json',
                             'Content-Type': 'application/json' } }

  before do
    post "/journeys/#{journey.id}/waypoints",
         set_waypoint_params(waypoint_1.latitude,
                             waypoint_1.longitude,
                             waypoint_1.description),
         request_headers

    post "/journeys/#{journey.id}/waypoints",
         set_waypoint_params(waypoint_2.latitude,
                             waypoint_2.longitude,
                             waypoint_2.description),
         request_headers
  end

  describe 'POST /journeys/:journey_id/waypoints' do
    it 'creates a waypoint' do
      expect(response.status).to eq 201
      expect(Waypoint.last.latitude).to eq waypoint_2.latitude
      expect(Waypoint.last.longitude).to eq waypoint_2.longitude
      expect(Waypoint.last.description).to eq waypoint_2.description
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
      expect(journey_data[0]["description"]).to eq waypoint_1.description

      waypoint_2_long = BigDecimal.new(journey_data[1]["longitude"])
      expect(waypoint_2_long).to eq waypoint_2.longitude
      expect(journey_data[1]["description"]).to eq waypoint_2.description
    end
  end

  describe 'PATCH /waypoints/:id' do
    it 'updates a waypoint' do
      waypoint = journey.waypoints.last
      patch "/waypoints/#{waypoint.id}",
            set_waypoint_params(waypoint.latitude,
                                waypoint.longitude,
                                "New waypoint description"),
            request_headers

      expect(response.status).to eq 200

      updated_waypoint = Waypoint.find(waypoint.id)
      expect(updated_waypoint.description).to eq "New waypoint description"
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
