require 'rails_helper'

describe 'routes API' do
  describe 'GET /routes' do
    it 'returns all the routes' do
      2.times { FactoryGirl.create(:route) }
      get '/routes', {}, { 'Accept' => 'application/json' }

      expect(response.status).to eq 200

      routes_data = JSON.parse(response.body)
      expect(routes_data[0]["id"]).to eq 1
      expect(routes_data[1]["id"]).to eq 2
    end
  end

  describe 'GET /routes/:id' do
    it 'returns the route and all its waypoints' do
      current_route = FactoryGirl.create(:route)
      request_headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
      }

      waypoint_1 = FactoryGirl.build(:waypoint)
      post "/routes/#{current_route.id}/waypoints",
           set_waypoint_params(waypoint_1.latitude, waypoint_1.longitude),
           request_headers

      waypoint_2 = FactoryGirl.build(:waypoint)
      post "/routes/#{current_route.id}/waypoints",
           set_waypoint_params(waypoint_2.latitude, waypoint_2.longitude),
           request_headers

      get "/routes/#{current_route.id}", {}, { 'Accept' => 'application/json' }

      expect(response.status).to eq 200

      current_route_data = JSON.parse(response.body)
      expect(current_route_data["route"]["id"]).to eq current_route.id

      waypoint_1_lat = current_route_data["waypoints"][0]["latitude"]
      expect(BigDecimal.new(waypoint_1_lat)).to eq waypoint_1.latitude

      waypoint_2_long = current_route_data["waypoints"][1]["longitude"]
      expect(BigDecimal.new(waypoint_2_long)).to eq waypoint_2.longitude
    end
  end
end
