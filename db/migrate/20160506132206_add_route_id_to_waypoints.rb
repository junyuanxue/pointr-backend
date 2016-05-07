class AddRouteIdToWaypoints < ActiveRecord::Migration
  def change
    add_reference :waypoints, :route, index: true, foreign_key: true
  end
end
