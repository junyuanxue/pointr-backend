class AddDescriptionToWaypoints < ActiveRecord::Migration
  def change
    add_column :waypoints, :description, :text
  end
end
