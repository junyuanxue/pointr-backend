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

  SCOPE = 10

  def show_distance_to(location)
    "#{calculate_distance_to(location)}m"
  end

  def near?(location)
    calculate_distance_to(location) <= SCOPE
  end

  private

  def calculate_distance_to(location)
    distance = distance_to([location[:latitude],
                            location[:longitude]],
                            units: :kms)
    (distance * 1000).round
  end
end
