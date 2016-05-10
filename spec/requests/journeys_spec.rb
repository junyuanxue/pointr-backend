require 'rails_helper'

describe 'journeys API' do
  let!(:request_headers) { { 'Accept': 'application/json',
                             'Content-Type': 'application/json' } }
  let!(:journey) { FactoryGirl.create(:journey) }

  describe 'POST /journeys' do
    it 'creates a new journey' do
      new_journey = FactoryGirl.build(:journey)
      post '/journeys',
           set_journey_params(new_journey.description),
           request_headers

      expect(response.status).to eq 201
      expect(Journey.last.description).to eq new_journey.description
    end
  end

  describe 'GET /journeys' do
    it 'returns all the journeys' do
      another_journey = FactoryGirl.create(:journey)
      get '/journeys', {}, { 'Accept': 'application/json' }

      expect(response.status).to eq 200

      journeys_data = JSON.parse(response.body)
      expect(journeys_data[0]["id"]).to eq journey.id
      expect(journeys_data[1]["description"]).to eq another_journey.description
    end
  end

  describe 'GET /journeys/:id' do
    it 'returns the journey and all its waypoints' do
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

  describe 'PATCH /journeys/:id' do
    it 'updates a journey' do
      patch "/journeys/#{journey.id}",
            set_journey_params("New journey description"),
            request_headers

      expect(response.status).to eq 200

      updated_journey = Journey.find(journey.id)
      expect(updated_journey.description).to eq "New journey description"
    end
  end

  describe 'DELETE /journeys/:id' do
    it 'deletes a journey' do
      delete "/journeys/#{journey.id}"

      expect(response.status).to eq 200
      expect(Journey.all).not_to include journey
    end
  end
end
