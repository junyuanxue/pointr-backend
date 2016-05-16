class RenameRouteToJourney < ActiveRecord::Migration
  def self.up
    rename_table :routes, :journeys
  end
  def self.down
    rename_table :routes, :journeys
  end
end
