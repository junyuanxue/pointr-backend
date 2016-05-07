def set_waypoint_params(latitude, longitude)
  { 'waypoint' =>
    {
      'latitude' => latitude,
      'longitude' => longitude
    }
  }.to_json
end
