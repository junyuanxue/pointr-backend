def set_waypoint_params(latitude, longitude, description='')
  { 'waypoint':
    {
      'latitude': latitude,
      'longitude': longitude,
      'description': description
    }
  }.to_json
end

def set_journey_params(description)
  { 'journey':
    { 'description': description }
  }.to_json
end
