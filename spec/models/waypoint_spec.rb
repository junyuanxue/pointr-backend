require 'rails_helper'

describe Waypoint, type: :model do

  it { is_expected.to belong_to :route }

  it 'validates the latitude' do
    invalid_waypoint = Waypoint.new(latitude: 100.0, longitude: 10.0)
    expect(invalid_waypoint.save).to be false
  end

  it 'validates the longitude' do
    invalid_waypoint = Waypoint.new(latitude: 10.0, longitude: 200.0)
    expect(invalid_waypoint.save).to be false
  end

end
