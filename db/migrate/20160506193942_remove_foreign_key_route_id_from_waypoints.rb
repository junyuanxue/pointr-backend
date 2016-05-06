class RemoveForeignKeyRouteIdFromWaypoints < ActiveRecord::Migration
  def change
    remove_foreign_key :waypoints, :routes
  end
end
