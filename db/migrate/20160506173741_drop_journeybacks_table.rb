class DropJourneybacksTable < ActiveRecord::Migration
  def down
    drop_table :journeybacks
  end
end
