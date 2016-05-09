def set_waypoint_params(latitude, longitude)
  { 'waypoint':
    {
      'latitude': latitude,
      'longitude': longitude
    }
  }.to_json
end

def set_journey_params(description)
  { 'journey':
    { 'description': description }
  }.to_json
end
