class RemoveRouteIdColumnFromWaypoints < ActiveRecord::Migration
  def change
    remove_column :waypoints, :route_id, :integer
  end
end
