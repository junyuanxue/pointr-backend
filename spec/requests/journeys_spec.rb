require 'rails_helper'

describe 'journeys API' do
  let!(:request_headers) { { 'Accept': 'application/json',
                             'Content-Type': 'application/json' } }

  describe 'POST /journeys' do
    it 'creates a new journey' do
      journey = FactoryGirl.build(:journey)
      post '/journeys',
           set_journey_params(journey.description),
           request_headers

      expect(response.status).to eq 201
      expect(Journey.last.description).to eq journey.description
    end
  end

  describe 'GET /journeys' do
    it 'returns all the journeys' do
      journey_1 = FactoryGirl.create(:journey)
      journey_2 = FactoryGirl.create(:journey)
      get '/journeys', {}, { 'Accept': 'application/json' }

      expect(response.status).to eq 200

      journeys_data = JSON.parse(response.body)
      expect(journeys_data[0]["id"]).to eq journey_1.id
      expect(journeys_data[1]["description"]).to eq journey_2.description
    end
  end

  describe 'GET /journeys/:id' do
    it 'returns the journey and all its waypoints' do
      journey = FactoryGirl.create(:journey)

      waypoint_1 = FactoryGirl.build(:waypoint)
      post "/journeys/#{journey.id}/waypoints",
           set_waypoint_params(waypoint_1.latitude, waypoint_1.longitude),
           request_headers

      waypoint_2 = FactoryGirl.build(:waypoint)
      post "/journeys/#{journey.id}/waypoints",
           set_waypoint_params(waypoint_2.latitude, waypoint_2.longitude),
           request_headers

      get "/journeys/#{journey.id}", {}, { 'Accept': 'application/json' }

      expect(response.status).to eq 200

      journey_data = JSON.parse(response.body)
      expect(journey_data["journey"]["id"]).to eq journey.id
      expect(journey_data["journey"]["description"]).to eq journey.description

      waypoint_1_lat = journey_data["waypoints"][0]["latitude"]
      expect(BigDecimal.new(waypoint_1_lat)).to eq waypoint_1.latitude

      waypoint_2_lng = journey_data["waypoints"][1]["longitude"]
      expect(BigDecimal.new(waypoint_2_lng)).to eq waypoint_2.longitude
    end
  end

  describe 'DELETE /journeys/:id' do
    it 'deletes a journey' do
      journey = FactoryGirl.create(:journey)
      delete "/journeys/#{journey.id}"

      expect(response.status).to eq 200
      expect(Journey.all).not_to include journey
    end
  end
end
