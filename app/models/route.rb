class Route < ActiveRecord::Base

  has_many :waypoints
  has_one :journeyback
end
