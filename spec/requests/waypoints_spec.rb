require 'rails_helper'
require 'bigdecimal'

describe 'waypoints API' do
  let!(:current_route) { FactoryGirl.create(:route) }
  let!(:waypoint_1) { FactoryGirl.build(:waypoint, route: current_route) }
  let!(:waypoint_2) { FactoryGirl.build(:waypoint, route: current_route) }

  before do
    request_headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }

    post "/routes/#{current_route.id}/waypoints",
         set_waypoint_params(waypoint_1.latitude, waypoint_1.longitude),
         request_headers

    post "/routes/#{current_route.id}/waypoints",
         set_waypoint_params(waypoint_2.latitude, waypoint_2.longitude),
         request_headers
  end

  describe 'POST /routes/:route_id/waypoints' do
    it 'creates a waypoint' do
      expect(response.status).to eq 201
      expect(Waypoint.last.latitude).to eq waypoint_2.latitude
      expect(Waypoint.last.longitude).to eq waypoint_2.longitude
      expect(Waypoint.last.route_id).to eq current_route.id
    end
  end

  describe 'GET /routes/:route_id/waypoints' do
    it 'return all the waypoints of a single route' do
      get "/routes/#{current_route.id}/waypoints", {}, { 'Accept' => 'application/json' }
      expect(response.status).to eq 200

      current_route_data = JSON.parse(response.body)
      waypoint_1_lat = BigDecimal.new(current_route_data[0]["latitude"])
      expect(waypoint_1_lat).to eq waypoint_1.latitude

      waypoint_2_long = BigDecimal.new(current_route_data[1]["longitude"])
      expect(waypoint_2_long).to eq waypoint_2.longitude
    end
  end

  describe 'DELETE /waypoints/:id' do
    it 'deletes a waypoint' do
      waypoint = current_route.waypoints.last

      delete "/waypoints/#{waypoint.id}"
      expect(response.status).to eq 200
      expect(current_route.waypoints).not_to include waypoint
    end
  end
end
