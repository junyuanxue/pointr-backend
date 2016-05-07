class AddJourneyIdToWaypoints < ActiveRecord::Migration
  def change
    add_reference :waypoints, :journey, index: true, foreign_key: true
  end
end
