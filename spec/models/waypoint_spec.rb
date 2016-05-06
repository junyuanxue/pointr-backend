require 'rails_helper'

describe Waypoint, type: :model do

  it { is_expected.to belong_to :journey }

  it 'validates the latitude' do
    invalid_waypoint = Waypoint.new(latitude: 100.0, longitude: 10.0)
    expect(invalid_waypoint.save).to be false
  end

  it 'validates the longitude' do
    invalid_waypoint = Waypoint.new(latitude: 10.0, longitude: 200.0)
    expect(invalid_waypoint.save).to be false
  end

  let!(:waypoint) { FactoryGirl.create(:waypoint, latitude: 51.517534, longitude: -0.073270) }

  describe '#get_distance_to' do
    it 'calculates the distance between current location and a waypoint' do
      here = { "latitude": 51.519825, "longitude": -0.075767 }
      p waypoint.get_distance_to(here)
      expect(waypoint.get_distance_to(here)).to eq "WHATEVER THE NUMBER SHOULD BE"
    end
  end

  describe '#near?' do
    it 'returns true when current location is near a waypoint' do
      here = { "latitude": 51.517534, "longitude": -0.073271 }
      expect(waypoint.near?(here)).to be true
    end

    it 'returns false when current location is not near a waypoint' do
      there = { "latitude": 51.523315, "longitude": -0.074730 }
      expect(waypoint.near?(there)).to be false
    end
  end
end
