class Waypoint < ActiveRecord::Base

  belongs_to :journey

  validates :latitude, numericality:
                       { greater_than_or_equal_to: -90,
                         less_than_or_equal_to: 90 }
  validates :longitude, numericality:
                        { greater_than_or_equal_to: -180,
                          less_than_or_equal_to: 180 }

  acts_as_mappable lat_column_name: :latitude,
                   lng_column_name: :longitude

  def get_distance_to(location)
    distance_to([location["latitude"], location["longitude"]], units: :kms)
  end

  def near?(location)
    get_distance_to(location) <= 10 #equivalent to 10 meters
  end
end
