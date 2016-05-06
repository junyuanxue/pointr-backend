require 'rails_helper'
require 'bigdecimal'

describe 'waypoints API' do
  describe 'POST /waypoints' do
    it 'creates a waypoint' do
      current_route = FactoryGirl.create(:route)
      waypoint_params = {
        'waypoint' => {
          'latitude' => 51.517320,
          'longitude' => -0.072583
        }
      }.to_json

      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      post "/routes/#{current_route.id}/waypoints", waypoint_params, request_headers

      expect(response.status).to eq 201
      expect(Waypoint.first.latitude).to eq BigDecimal.new(51.517320, 7)
      expect(Waypoint.first.longitude).to eq BigDecimal.new(-0.072583, 7)
      expect(Waypoint.first.route_id).to eq current_route.id
    end
  end
end
