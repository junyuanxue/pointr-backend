require 'rails_helper'

describe 'routes API' do
  describe 'GET /routes' do
    it 'returns routes in a json object' do
      2.times { FactoryGirl.create(:route) }
      get '/routes', {}, { 'Accept' => 'application/json' }

      expect(response.status).to eq 200

      routes_data = JSON.parse(response.body)
      expect(routes_data[0]["id"]).to eq 1
      expect(routes_data[1]["id"]).to eq 2
    end
  end
end
