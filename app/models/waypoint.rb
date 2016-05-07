class Waypoint < ActiveRecord::Base

  belongs_to :journey

  validates :latitude, numericality:
                       { greater_than_or_equal_to: -90,
                         less_than_or_equal_to: 90 }
  validates :longitude, numericality:
                        { greater_than_or_equal_to: -180,
                          less_than_or_equal_to: 180 }

end
